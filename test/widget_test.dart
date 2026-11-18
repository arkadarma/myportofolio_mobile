import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/validators/education_form_validators.dart';

void main() {
  testWidgets('home retains the profile and all portfolio action cards', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('2506656791'), findsOneWidget);
    expect(find.text('I Komang Arka Darma Laksana'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);
    expect(find.text('Lihat Portofolio'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Burhan'), findsNothing);

    final cards = tester
        .widgetList<Material>(find.byType(Material))
        .where(
          (material) => material.borderRadius == BorderRadius.circular(12),
        );
    expect(cards.map((card) => card.color).toSet(), hasLength(4));
  });

  testWidgets('non-navigation action cards still show their SnackBars', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    for (final action in ['Lihat Portofolio', 'Logout']) {
      await tester.tap(find.text(action));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Kamu telah menekan tombol $action!'), findsOneWidget);
    }
  });

  testWidgets('Tambah Proyek opens its form and supports Back', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
  });

  testWidgets(
    'drawer preserves Add Project and navigates to Education and Home',
    (tester) async {
      await tester.pumpWidget(const MyApp());

      tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
      await tester.pumpAndSettle();
      expect(find.text('My Portfolio'), findsOneWidget);
      expect(
        find.text('Explore personal projects and experiences!'),
        findsOneWidget,
      );

      await tester.tap(find.text('Add Project'));
      await tester.pumpAndSettle();
      expect(find.text('Add Project Form'), findsOneWidget);

      tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Education'));
      await tester.pumpAndSettle();
      expect(find.byType(EducationFormPage), findsOneWidget);

      tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('MyPortfolio'), findsOneWidget);
      expect(find.text('Profil Pemilik'), findsOneWidget);

      await tester.tap(find.text('Tambah Pendidikan'));
      await tester.pumpAndSettle();
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('MyPortfolio'), findsOneWidget);
    },
  );

  testWidgets('home layout adapts to a narrow mobile width', (tester) async {
    _setScreenSize(tester, const Size(320, 480));
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('project form scrolls on a short screen without overflow', (
    tester,
  ) async {
    _setScreenSize(tester, const Size(320, 480));
    await tester.pumpWidget(const MyApp());
    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    final scrollView = find.byType(SingleChildScrollView);
    expect(find.text('Save').hitTestable(), findsNothing);
    await tester.drag(scrollView, const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Save').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('form validates required fields, displays data, and resets', (
    tester,
  ) async {
    _setScreenSize(tester, const Size(390, 844));
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Web Development'), findsOneWidget);
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Proyek berhasil ditambahkan!'), findsNothing);

    await _enterTextField(tester, 0, 'Portfolio App');
    await _enterTextField(tester, 1, 'A mobile portfolio application.');

    final categoryField = find.byWidgetPredicate(
      (widget) => widget is DropdownButtonFormField<String>,
    );
    await tester.ensureVisible(categoryField);
    await tester.ensureVisible(find.text('Web Development'));
    await tester.tap(find.text('Web Development'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mobile Development'));
    await tester.pumpAndSettle();

    await _enterTextField(tester, 2, 'Flutter, Dart');
    await _enterTextField(tester, 3, 'https://example.com/project');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
    expect(find.text('Nama Proyek: Portfolio App'), findsOneWidget);
    expect(
      find.text('Deskripsi: A mobile portfolio application.'),
      findsOneWidget,
    );
    expect(find.text('Kategori: Mobile Development'), findsOneWidget);
    expect(find.text('Teknologi: Flutter, Dart'), findsOneWidget);
    expect(find.text('Tautan: https://example.com/project'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(_textFieldValue(tester, 0), isEmpty);
    expect(_textFieldValue(tester, 1), isEmpty);
    expect(_textFieldValue(tester, 2), isEmpty);
    expect(_textFieldValue(tester, 3), isEmpty);
    expect(find.text('Web Development'), findsOneWidget);

    await _enterTextField(tester, 0, 'Minimal Project');
    await _enterTextField(tester, 1, 'Required fields are enough.');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Nama Proyek: Minimal Project'), findsOneWidget);
    expect(find.textContaining('Teknologi:'), findsOneWidget);
    expect(find.textContaining('Tautan:'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('education form rejects empty required fields', (tester) async {
    await _openEducationForm(tester);
    await _tapSave(tester);

    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    expect(find.text('Pilih jenjang pendidikan.'), findsOneWidget);
    expect(
      find.text('Jurusan atau program studi wajib diisi.'),
      findsOneWidget,
    );
    expect(
      find.text('Tahun masuk harus berupa 4 digit angka.'),
      findsOneWidget,
    );
    expect(
      find.text('Tahun lulus harus berupa 4 digit angka.'),
      findsOneWidget,
    );
    expect(find.text('Ringkasan Pendidikan'), findsNothing);

    await tester.enterText(
      find.byKey(const ValueKey('institution-field')),
      'Universitas Indonesia',
    );
    await tester.pumpAndSettle();
    expect(find.text('Nama institusi wajib diisi.'), findsNothing);
  });

  testWidgets('education form trims values and shows a complete summary', (
    tester,
  ) async {
    _setScreenSize(tester, const Size(390, 844));
    await _openEducationForm(tester);
    await _fillEducationForm(
      tester,
      institution: '  Universitas Indonesia  ',
      major: '  Ilmu Komputer ',
      startYear: '2022',
      graduationYear: '${DateTime.now().year}',
      description: '  Penghargaan akademik  ',
    );
    await _tapSave(tester);

    expect(find.text('Ringkasan Pendidikan'), findsOneWidget);
    expect(find.text('Universitas Indonesia'), findsOneWidget);
    expect(find.text('Ilmu Komputer'), findsOneWidget);
    expect(find.text('2022'), findsNWidgets(2));
    expect(find.text('Lulus tahun ${DateTime.now().year}'), findsOneWidget);
    expect(find.text('Penghargaan akademik'), findsOneWidget);

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
    expect(find.byType(EducationFormPage), findsOneWidget);
  });

  testWidgets('education form rejects whitespace and reversed years', (
    tester,
  ) async {
    await _openEducationForm(tester);
    await _fillEducationForm(
      tester,
      institution: '   ',
      major: '   ',
      startYear: '2025',
      graduationYear: '2024',
    );
    await _tapSave(tester);

    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    expect(
      find.text('Jurusan atau program studi wajib diisi.'),
      findsOneWidget,
    );
    expect(
      find.text('Tahun lulus tidak boleh sebelum tahun masuk.'),
      findsOneWidget,
    );
    expect(find.text('Ringkasan Pendidikan'), findsNothing);
  });

  testWidgets('ongoing education hides graduation year and is summarized', (
    tester,
  ) async {
    await _openEducationForm(tester);
    await _fillEducationForm(tester, graduationYear: null, startYear: '2024');
    await tester.tap(find.byKey(const ValueKey('ongoing-switch')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('graduation-year-false')), findsNothing);
    await _tapSave(tester);

    expect(find.text('Sedang berlangsung'), findsOneWidget);
    expect(find.text('Tahun lulus'), findsNothing);
  });

  testWidgets('ongoing status clears the hidden graduation validation error', (
    tester,
  ) async {
    await _openEducationForm(tester);
    await _tapSave(tester);
    expect(
      find.text('Tahun lulus harus berupa 4 digit angka.'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const ValueKey('ongoing-switch')));
    await tester.pumpAndSettle();
    expect(find.text('Tahun lulus harus berupa 4 digit angka.'), findsNothing);
  });

  testWidgets('reset confirmation keeps data on cancel and clears on confirm', (
    tester,
  ) async {
    await _openEducationForm(tester);
    await _tapSave(tester);
    expect(find.text('Nama institusi wajib diisi.'), findsOneWidget);
    await _fillEducationForm(tester, graduationYear: null);
    await tester.tap(find.byKey(const ValueKey('ongoing-switch')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Reset'));
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();

    expect(find.text('Batal'), findsOneWidget);
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(_fieldValue(tester, 'institution-field'), 'Universitas Indonesia');
    expect(find.byKey(const ValueKey('graduation-year-false')), findsNothing);
    expect(
      tester
          .widget<SwitchListTile>(find.byKey(const ValueKey('ongoing-switch')))
          .value,
      isTrue,
    );
    expect(
      tester
          .widget<DropdownButtonFormField<String>>(
            find.byWidgetPredicate(
              (widget) => widget is DropdownButtonFormField<String>,
            ),
          )
          .initialValue,
      'S1',
    );

    await tester.ensureVisible(find.text('Reset'));
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset').last);
    await tester.pumpAndSettle();

    expect(_fieldValue(tester, 'institution-field'), isEmpty);
    expect(_fieldValue(tester, 'major-field'), isEmpty);
    expect(_fieldValue(tester, 'start-year-field'), isEmpty);
    expect(_fieldValue(tester, 'description-field'), isEmpty);
    expect(find.byKey(const ValueKey('graduation-year-false')), findsOneWidget);
    expect(
      tester
          .widget<SwitchListTile>(find.byKey(const ValueKey('ongoing-switch')))
          .value,
      isFalse,
    );
    expect(find.text('Nama institusi wajib diisi.'), findsNothing);
    expect(
      tester
          .widget<DropdownButtonFormField<String>>(
            find.byWidgetPredicate(
              (widget) => widget is DropdownButtonFormField<String>,
            ),
          )
          .initialValue,
      isNull,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('description counter updates and input is capped at 400', (
    tester,
  ) async {
    await _openEducationForm(tester);
    final description = find.byKey(const ValueKey('description-field'));
    await tester.enterText(description, 'Pencapaian');
    await tester.pump();
    expect(find.text('10/400 karakter'), findsOneWidget);

    await tester.enterText(description, 'a' * 401);
    await tester.pump();
    expect(_fieldValue(tester, 'description-field').length, 400);
    expect(find.text('400/400 karakter'), findsOneWidget);
  });

  testWidgets(
    'education form and summary remain scrollable on a small screen',
    (tester) async {
      _setScreenSize(tester, const Size(320, 480));
      await _openEducationForm(tester);
      tester.view.viewInsets = const FakeViewPadding(bottom: 260);
      await tester.pumpAndSettle();

      await tester.ensureVisible(
        find.byKey(const ValueKey('description-field')),
      );
      await tester.enterText(
        find.byKey(const ValueKey('description-field')),
        'Pencapaian akademik yang cukup panjang untuk memastikan konten dialog '
        'tetap dapat dibaca pada layar sempit.',
      );
      await tester.ensureVisible(find.text('Simpan'));
      expect(find.text('Simpan').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);

      tester.view.viewInsets = FakeViewPadding.zero;
      await tester.pumpAndSettle();
      await _fillEducationForm(tester, graduationYear: '2026');
      await _tapSave(tester);
      expect(find.text('Ringkasan Pendidikan'), findsOneWidget);
      expect(find.text('Tutup').hitTestable(), findsOneWidget);
      await tester.drag(
        find.byType(SingleChildScrollView).last,
        const Offset(0, -160),
      );
      await tester.pumpAndSettle();
      expect(find.text('Lulus tahun 2026'), findsOneWidget);
      expect(find.text('Tutup').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  test('education validators reject malformed and implausible years', () {
    final currentYear = DateTime.now().year;
    expect(
      EducationFormValidators.institution('   '),
      'Nama institusi wajib diisi.',
    );
    expect(
      EducationFormValidators.institution('I' * 101),
      'Nama institusi maksimal 100 karakter.',
    );
    expect(EducationFormValidators.level(null), 'Pilih jenjang pendidikan.');
    expect(EducationFormValidators.major('  '), isNotNull);
    expect(
      EducationFormValidators.startYear('20x4', currentYear: currentYear),
      'Tahun masuk harus berupa 4 digit angka.',
    );
    expect(
      EducationFormValidators.startYear('1899', currentYear: currentYear),
      'Tahun masuk harus antara 1900 dan $currentYear.',
    );
    expect(
      EducationFormValidators.startYear(
        '${currentYear + 1}',
        currentYear: currentYear,
      ),
      'Tahun masuk harus antara 1900 dan $currentYear.',
    );
    expect(
      EducationFormValidators.graduationYear(
        '',
        currentYear: currentYear,
        startYear: currentYear - 1,
        isOngoing: true,
      ),
      isNull,
    );
    expect(
      EducationFormValidators.graduationYear(
        '20x4',
        currentYear: currentYear,
        startYear: currentYear - 1,
        isOngoing: false,
      ),
      'Tahun lulus harus berupa 4 digit angka.',
    );
    expect(
      EducationFormValidators.graduationYear(
        '${currentYear + 1}',
        currentYear: currentYear,
        startYear: currentYear - 1,
        isOngoing: false,
      ),
      'Tahun lulus harus antara 1900 dan $currentYear.',
    );
    expect(
      EducationFormValidators.description('D' * 401),
      'Deskripsi maksimal 400 karakter.',
    );
  });
}

Future<void> _enterTextField(
  WidgetTester tester,
  int index,
  String text,
) async {
  final field = find.byType(TextFormField).at(index);
  await tester.ensureVisible(field);
  await tester.enterText(field, text);
}

void _setScreenSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

String _textFieldValue(WidgetTester tester, int index) {
  final field = find.byType(TextFormField).at(index);
  final editable = find.descendant(
    of: field,
    matching: find.byType(EditableText),
  );
  return tester.widget<EditableText>(editable).controller.text;
}

Future<void> _openEducationForm(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.ensureVisible(find.text('Tambah Pendidikan'));
  await tester.tap(find.text('Tambah Pendidikan'));
  await tester.pumpAndSettle();
  expect(find.byType(EducationFormPage), findsOneWidget);
}

Future<void> _fillEducationForm(
  WidgetTester tester, {
  String institution = 'Universitas Indonesia',
  String major = 'Ilmu Komputer',
  String startYear = '2022',
  String? graduationYear = '2026',
  String? description,
  String level = 'S1',
}) async {
  await tester.enterText(
    find.byKey(const ValueKey('institution-field')),
    institution,
  );
  final levelField = find.byKey(const ValueKey('education-level-0'));
  await tester.ensureVisible(levelField);
  await tester.tap(levelField);
  await tester.pumpAndSettle();
  await tester.tap(find.text(level).last);
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const ValueKey('major-field')), major);
  await tester.enterText(
    find.byKey(const ValueKey('start-year-field')),
    startYear,
  );
  if (graduationYear != null) {
    final field = find.byKey(const ValueKey('graduation-year-false'));
    if (field.evaluate().isNotEmpty) {
      await tester.enterText(field, graduationYear);
    }
  }
  if (description != null) {
    await tester.enterText(
      find.byKey(const ValueKey('description-field')),
      description,
    );
  }
}

Future<void> _tapSave(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Simpan'));
  await tester.tap(find.text('Simpan'));
  await tester.pumpAndSettle();
}

String _fieldValue(WidgetTester tester, String key) {
  final field = find.byKey(ValueKey(key));
  final editable = find.descendant(
    of: field,
    matching: find.byType(EditableText),
  );
  return tester.widget<EditableText>(editable).controller.text;
}
