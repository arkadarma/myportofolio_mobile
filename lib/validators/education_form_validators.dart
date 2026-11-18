/// Validation rules for the education form, kept separate from its widgets.
abstract final class EducationFormValidators {
  static const int institutionMaxLength = 100;
  static const int majorMaxLength = 100;
  static const int descriptionMaxLength = 400;
  static const int earliestYear = 1900;

  static String? institution(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Nama institusi wajib diisi.';
    if (trimmed.length > institutionMaxLength) {
      return 'Nama institusi maksimal $institutionMaxLength karakter.';
    }
    return null;
  }

  static String? level(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pilih jenjang pendidikan.';
    }
    return null;
  }

  static String? major(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Jurusan atau program studi wajib diisi.';
    if (trimmed.length > majorMaxLength) {
      return 'Jurusan maksimal $majorMaxLength karakter.';
    }
    return null;
  }

  static String? startYear(String? value, {required int currentYear}) {
    final year = _parseYear(value);
    if (year == null) return 'Tahun masuk harus berupa 4 digit angka.';
    if (year < earliestYear || year > currentYear) {
      return 'Tahun masuk harus antara $earliestYear dan $currentYear.';
    }
    return null;
  }

  static String? graduationYear(
    String? value, {
    required int currentYear,
    required int? startYear,
    required bool isOngoing,
  }) {
    if (isOngoing) return null;

    final year = _parseYear(value);
    if (year == null) return 'Tahun lulus harus berupa 4 digit angka.';
    if (year < earliestYear || year > currentYear) {
      return 'Tahun lulus harus antara $earliestYear dan $currentYear.';
    }
    if (startYear != null && year < startYear) {
      return 'Tahun lulus tidak boleh sebelum tahun masuk.';
    }
    return null;
  }

  static String? description(String? value) {
    if ((value?.length ?? 0) > descriptionMaxLength) {
      return 'Deskripsi maksimal $descriptionMaxLength karakter.';
    }
    return null;
  }

  static int? _parseYear(String? value) {
    final trimmed = value?.trim() ?? '';
    if (!RegExp(r'^\d{4}$').hasMatch(trimmed)) return null;
    return int.tryParse(trimmed);
  }
}
