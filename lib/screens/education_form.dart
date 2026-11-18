import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education_entry.dart';
import 'package:myportofolio_mobile/validators/education_form_validators.dart';
import 'package:myportofolio_mobile/widgets/education_summary_dialog.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key, required this.drawer});

  final LeftDrawer drawer;

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  static const List<String> _educationLevels = [
    'SMA/SMK',
    'Diploma',
    'S1',
    'S2',
    'S3',
  ];

  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _majorController = TextEditingController();
  final _startYearController = TextEditingController();
  final _graduationYearController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedLevel;
  bool _isOngoing = false;
  bool _hasSubmitted = false;
  int _resetGeneration = 0;

  int get _currentYear => DateTime.now().year;

  @override
  void dispose() {
    _institutionController.dispose();
    _majorController.dispose();
    _startYearController.dispose();
    _graduationYearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pendidikan'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      drawer: widget.drawer,
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _hasSubmitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _FormIntroduction(colorScheme: colorScheme),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const ValueKey('institution-field'),
                      controller: _institutionController,
                      textCapitalization: TextCapitalization.words,
                      maxLength: EducationFormValidators.institutionMaxLength,
                      decoration: _fieldDecoration(
                        label: 'Nama institusi',
                        hint: 'Contoh: Universitas Indonesia',
                        icon: Icons.account_balance_outlined,
                      ),
                      validator: EducationFormValidators.institution,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      key: ValueKey('education-level-$_resetGeneration'),
                      initialValue: _selectedLevel,
                      isExpanded: true,
                      decoration: _fieldDecoration(
                        label: 'Jenjang pendidikan',
                        icon: Icons.school_outlined,
                      ),
                      items: _educationLevels
                          .map(
                            (level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedLevel = value);
                      },
                      validator: EducationFormValidators.level,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('major-field'),
                      controller: _majorController,
                      textCapitalization: TextCapitalization.words,
                      maxLength: EducationFormValidators.majorMaxLength,
                      decoration: _fieldDecoration(
                        label: 'Jurusan / program studi',
                        hint: 'Contoh: Ilmu Komputer',
                        icon: Icons.menu_book_outlined,
                      ),
                      validator: EducationFormValidators.major,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('start-year-field'),
                      controller: _startYearController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: _fieldDecoration(
                        label: 'Tahun masuk',
                        hint: 'Contoh: 2022',
                        icon: Icons.calendar_today_outlined,
                      ),
                      validator: (value) => EducationFormValidators.startYear(
                        value,
                        currentYear: _currentYear,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _OngoingEducationTile(
                      value: _isOngoing,
                      onChanged: (value) {
                        setState(() => _isOngoing = value);
                      },
                    ),
                    if (!_isOngoing) ...[
                      const SizedBox(height: 16),
                      TextFormField(
                        key: ValueKey('graduation-year-$_isOngoing'),
                        controller: _graduationYearController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        decoration: _fieldDecoration(
                          label: 'Tahun lulus',
                          hint: 'Contoh: 2026',
                          icon: Icons.event_available_outlined,
                        ),
                        validator: (value) =>
                            EducationFormValidators.graduationYear(
                              value,
                              currentYear: _currentYear,
                              startYear: int.tryParse(
                                _startYearController.text.trim(),
                              ),
                              isOngoing: _isOngoing,
                            ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('description-field'),
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: EducationFormValidators.descriptionMaxLength,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: _fieldDecoration(
                        label: 'Deskripsi / pencapaian (opsional)',
                        hint: 'Ceritakan fokus studi, pencapaian, atau kegiatan yang relevan.',
                        icon: Icons.notes_outlined,
                      ).copyWith(counterText: ''),
                      validator: EducationFormValidators.description,
                      onChanged: (_) => setState(() {}),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        '${_descriptionController.text.length}/'
                        '${EducationFormValidators.descriptionMaxLength} karakter',
                        key: const ValueKey('description-counter'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _FormActions(onSave: _submitForm, onReset: _confirmReset),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      alignLabelWithHint: true,
    );
  }

  void _submitForm() {
    setState(() => _hasSubmitted = true);
    if (!_formKey.currentState!.validate()) return;

    final entry = EducationEntry(
      institution: _institutionController.text.trim(),
      level: _selectedLevel!,
      major: _majorController.text.trim(),
      startYear: int.parse(_startYearController.text.trim()),
      graduationYear: _isOngoing
          ? null
          : int.parse(_graduationYearController.text.trim()),
      isOngoing: _isOngoing,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    showDialog<void>(
      context: context,
      builder: (_) => EducationSummaryDialog(entry: entry),
    );
  }

  Future<void> _confirmReset() async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset formulir?'),
        content: const Text(
          'Semua isian akan dihapus dan pilihan dikembalikan ke nilai awal.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (shouldReset != true || !mounted) return;

    _formKey.currentState!.reset();
    _institutionController.clear();
    _majorController.clear();
    _startYearController.clear();
    _graduationYearController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedLevel = null;
      _isOngoing = false;
      _hasSubmitted = false;
      _resetGeneration++;
    });
  }
}

class _FormIntroduction extends StatelessWidget {
  const _FormIntroduction({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.school_outlined, color: colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Riwayat pendidikan',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Isi informasi pendidikan untuk melengkapi portofolio. '
                  'Kolom bertanda opsional boleh dikosongkan.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OngoingEducationTile extends StatelessWidget {
  const _OngoingEducationTile({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: SwitchListTile.adaptive(
        key: const ValueKey('ongoing-switch'),
        value: value,
        onChanged: onChanged,
        title: const Text('Pendidikan masih berlangsung'),
        subtitle: const Text('Tahun lulus tidak diperlukan selama aktif.'),
        secondary: const Icon(Icons.autorenew),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class _FormActions extends StatelessWidget {
  const _FormActions({required this.onSave, required this.onReset});

  final VoidCallback onSave;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Reset'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Simpan'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
