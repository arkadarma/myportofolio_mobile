import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education_entry.dart';

/// Readable, scrollable confirmation of the values submitted by the user.
class EducationSummaryDialog extends StatelessWidget {
  const EducationSummaryDialog({super.key, required this.entry});

  final EducationEntry entry;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.school_outlined),
      title: const Text('Ringkasan Pendidikan'),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.42,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SummaryRow(label: 'Institusi', value: entry.institution),
              _SummaryRow(label: 'Jenjang', value: entry.level),
              _SummaryRow(label: 'Jurusan', value: entry.major),
              _SummaryRow(label: 'Tahun masuk', value: '${entry.startYear}'),
              _SummaryRow(
                label: 'Status',
                value: entry.isOngoing
                    ? 'Sedang berlangsung'
                    : 'Lulus tahun ${entry.graduationYear}',
              ),
              if (entry.description != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Deskripsi / pencapaian',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(entry.description!),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }
}
