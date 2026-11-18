import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('home retains the Tutorial 08 profile and action cards', (
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
    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Burhan'), findsNothing);

    final cards = tester
        .widgetList<Material>(find.byType(Material))
        .where(
          (material) => material.borderRadius == BorderRadius.circular(12),
        );
    expect(cards.map((card) => card.color).toSet(), hasLength(3));
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

  testWidgets(
    'Tambah Proyek keeps its SnackBar, opens form, and supports Back',
    (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();

      expect(
        find.text('Kamu telah menekan tombol Tambah Proyek!'),
        findsOneWidget,
      );
      expect(find.text('Add Project Form'), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('MyPortfolio'), findsOneWidget);
      expect(find.text('Tambah Proyek'), findsOneWidget);
    },
  );

  testWidgets('drawer navigates Home and Add Project from both screens', (
    tester,
  ) async {
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
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.text('Add Project Form'), findsOneWidget);

    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Profil Pemilik'), findsOneWidget);
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
