/// Immutable, validated education data passed from the form to its summary.
class EducationEntry {
  const EducationEntry({
    required this.institution,
    required this.level,
    required this.major,
    required this.startYear,
    required this.isOngoing,
    required this.description,
    this.graduationYear,
  });

  final String institution;
  final String level;
  final String major;
  final int startYear;
  final int? graduationYear;
  final bool isOngoing;
  final String? description;
}
