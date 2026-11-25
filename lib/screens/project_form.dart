import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key, required this.drawer});

  final LeftDrawer drawer;

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (_isSubmitting || !form.validate()) return;
    form.save();
    setState(() => _isSubmitting = true);

    try {
      if (!await ensureLoggedIn(context) || !mounted) return;
      final auth = context.read<AuthState>();
      final token = auth.token;
      if (token == null) return;
      final saved = await context.read<ApiClient>().createProject(
        Project(
          title: _title,
          description: _description,
          techStack: _techStack,
          projectUrl: _projectUrl,
          projectImageUrl: _projectImageUrl,
        ),
        token: token,
      );
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Proyek: ${saved.title}'),
                Text('Deskripsi: ${saved.description}'),
                Text('Teknologi: ${saved.techStack}'),
                Text('Tautan: ${saved.projectUrl}'),
                if (saved.projectImageUrl.isNotEmpty)
                  Text('Gambar: ${saved.projectImageUrl}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (mounted) _formKey.currentState!.reset();
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        _showMessage('Sesi berakhir. Silakan login kembali.');
        final loggedIn = await ensureLoggedIn(context);
        if (!mounted) return;
        if (loggedIn) {
          _showMessage('Silakan tekan Save untuk mengirim ulang.');
        } else {
          Navigator.pop(context);
        }
      } else {
        final message = switch (error.statusCode) {
          400 => 'Periksa isian proyek.',
          403 => 'Hanya pemilik portofolio yang dapat menambahkan proyek.',
          _ => 'Coba lagi nanti.',
        };
        _showMessage(
          'Gagal menyimpan proyek (HTTP ${error.statusCode}). $message',
        );
      }
    } on Exception {
      if (mounted) {
        _showMessage('Gagal menyimpan proyek. Periksa koneksi ke server.');
      }
    } finally {
      if (mounted && _isSubmitting) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateUrl(String? value, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return required ? 'URL proyek wajib diisi.' : null;
    final url = Uri.tryParse(text);
    if (url == null ||
        !(url.isScheme('https') || url.isScheme('http')) ||
        url.host.isEmpty ||
        text.contains(RegExp(r'\s'))) {
      return 'Masukkan URL HTTP atau HTTPS yang valid.';
    }
    return null;
  }

  Widget _field({
    required String label,
    required ValueChanged<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        enabled: !_isSubmitting,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        ),
        validator: validator,
        onSaved: (value) => onSaved(value!.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: widget.drawer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _field(
                label: 'Title',
                onSaved: (value) => _title = value,
                validator: (value) {
                  final title = value?.trim() ?? '';
                  if (title.isEmpty) return 'Nama proyek tidak boleh kosong!';
                  if (title.length > 255) {
                    return 'Nama proyek maksimal 255 karakter.';
                  }
                  return null;
                },
              ),
              _field(
                label: 'Description',
                maxLines: 5,
                onSaved: (value) => _description = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Deskripsi proyek tidak boleh kosong!'
                    : null,
              ),
              _field(
                label: 'Tech Stack',
                onSaved: (value) => _techStack = value,
                validator: (value) {
                  final techStack = value?.trim() ?? '';
                  if (techStack.isEmpty) return 'Teknologi wajib diisi.';
                  if (techStack.length > 255) {
                    return 'Teknologi maksimal 255 karakter.';
                  }
                  return null;
                },
              ),
              _field(
                label: 'Project URL',
                keyboardType: TextInputType.url,
                onSaved: (value) => _projectUrl = value,
                validator: (value) => _validateUrl(value, required: true),
              ),
              _field(
                label: 'Project Image URL (Optional)',
                keyboardType: TextInputType.url,
                onSaved: (value) => _projectImageUrl = value,
                validator: _validateUrl,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
