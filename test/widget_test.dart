import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/project_detail_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/validators/education_form_validators.dart';

void main() {
  testWidgets('home retains the profile and all portfolio action cards', (
    tester,
  ) async {
    await tester.pumpWidget(_app());

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('2506656791'), findsOneWidget);
    expect(find.text('I Komang Arka Darma Laksana'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);
    expect(find.text('Lihat Portofolio'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Burhan'), findsNothing);

    final cards = tester
        .widgetList<Material>(find.byType(Material))
        .where(
          (material) => material.borderRadius == BorderRadius.circular(12),
        );
    expect(cards.map((card) => card.color).toSet(), hasLength(4));
  });

  testWidgets('public project list and detail open from the portfolio card', (
    tester,
  ) async {
    final response = Completer<http.Response>();
    await tester.pumpWidget(
      _app((request) {
        expect(request.method, 'GET');
        expect(request.url.path, '/api/v1/projects/');
        expect(request.headers['Authorization'], isNull);
        return response.future;
      }),
    );
    await tester.tap(find.text('Lihat Portofolio'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    response.complete(_json([_project]));
    await tester.pumpAndSettle();

    expect(find.text('Portfolio App'), findsOneWidget);
    await tester.tap(find.text('Portfolio App'));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectDetailScreen), findsOneWidget);
    expect(find.text('A mobile portfolio application.'), findsOneWidget);
    expect(find.text('Flutter, Dart'), findsOneWidget);
    expect(find.text('https://example.com/project'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testWidgets(
    'project list retries and refreshes both empty and filled lists',
    (tester) async {
      var requests = 0;
      await tester.pumpWidget(
        _app((_) async {
          return switch (++requests) {
            1 => http.Response('Raw server error', 500),
            2 => _json([]),
            3 => _json([_project]),
            _ => http.Response('Raw server error', 503),
          };
        }),
      );
      await tester.tap(find.text('Lihat Portofolio'));
      await tester.pumpAndSettle();
      expect(find.text('Gagal memuat proyek (HTTP 500).'), findsOneWidget);
      expect(find.textContaining('Raw server error'), findsNothing);

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(find.text('No projects found.'), findsOneWidget);
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, 350),
      );
      await tester.pumpAndSettle();
      expect(find.text('Portfolio App'), findsOneWidget);

      await tester.drag(find.byType(ListView).last, const Offset(0, 350));
      await tester.pumpAndSettle();
      expect(find.text('Gagal memuat proyek (HTTP 503).'), findsOneWidget);
      expect(requests, 4);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Tambah Proyek requires login and supports cancellation and Back',
    (tester) async {
      await tester.pumpWidget(_app());

      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Add Project Form'), findsNothing);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Tambah Proyek'), findsOneWidget);

      await _openProjectForm(tester);
      expect(find.text('Add Project Form'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('MyPortfolio'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);

      await tester.tap(find.text('Tambah Proyek'));
      await tester.pumpAndSettle();
      expect(find.text('Add Project Form'), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
    },
  );

  testWidgets(
    'drawer preserves Add Project and navigates to Education and Home',
    (tester) async {
      await tester.pumpWidget(_app());

      tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
      await tester.pumpAndSettle();
      expect(find.text('My Portfolio'), findsOneWidget);
      expect(
        find.text('Explore personal projects and experiences!'),
        findsOneWidget,
      );

      await tester.tap(find.text('Add Project'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
      await _login(tester);
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
    await tester.pumpWidget(_app());

    expect(find.text('Tambah Pendidikan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('project form scrolls on a short screen without overflow', (
    tester,
  ) async {
    _setScreenSize(tester, const Size(320, 480));
    await tester.pumpWidget(_app());
    await _openProjectForm(tester);

    final scrollView = find.byType(SingleChildScrollView);
    expect(find.text('Save').hitTestable(), findsNothing);
    await tester.drag(scrollView, const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Save').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'project form validates, posts with a token and resets after 201',
    (tester) async {
      _setScreenSize(tester, const Size(390, 844));
      var writes = 0;
      await tester.pumpWidget(
        _app((request) async {
          if (request.url.path == '/api/v1/auth/token/') {
            return _json({'token': 'fixture-token'});
          }
          expect(request.url.path, '/api/v1/projects/');
          expect(request.method, 'POST');
          expect(request.headers['Authorization'], 'Token fixture-token');
          expect(
            request.headers['Content-Type'],
            'application/json; charset=UTF-8',
          );
          final payload = jsonDecode(request.body) as Map<String, dynamic>;
          final fields = Map.of(_project)..remove('id');
          expect(payload, fields);
          writes++;
          return _json(_project, 201);
        }),
      );
      await _openProjectForm(tester);
      await _tapProjectSave(tester);
      expect(find.text('Nama proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Deskripsi proyek tidak boleh kosong!'), findsOneWidget);
      expect(find.text('Teknologi wajib diisi.'), findsOneWidget);
      expect(find.text('URL proyek wajib diisi.'), findsOneWidget);

      await _fillProject(tester, url: 'invalid-url');
      await _tapProjectSave(tester);
      expect(
        find.text('Masukkan URL HTTP atau HTTPS yang valid.'),
        findsOneWidget,
      );
      expect(writes, 0);
      await _enterTextField(tester, 3, 'https://example.com/project');
      await _tapProjectSave(tester);

      expect(writes, 1);
      expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
      expect(find.text('Nama Proyek: Portfolio App'), findsOneWidget);
      expect(find.text('Teknologi: Flutter, Dart'), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      for (var i = 0; i < 5; i++) {
        expect(_textFieldValue(tester, i), isEmpty);
      }
    },
  );

  testWidgets('401 clears the token, prompts for login and keeps the draft', (
    tester,
  ) async {
    var loginCount = 0;
    var writeCount = 0;
    var logoutCount = 0;
    await tester.pumpWidget(
      _app((request) async {
        switch (request.url.path) {
          case '/api/v1/auth/token/':
            return _json({'token': 'fixture-token-${++loginCount}'});
          case '/api/v1/auth/logout/':
            logoutCount++;
            expect(request.headers['Authorization'], 'Token fixture-token-1');
            return http.Response('', 401);
          case '/api/v1/projects/':
            writeCount++;
            expect(
              request.headers['Authorization'],
              'Token fixture-token-$writeCount',
            );
            return writeCount == 1
                ? http.Response('', 401)
                : _json(_project, 201);
          default:
            fail('Unexpected request: ${request.url.path}');
        }
      }),
    );
    await _openProjectForm(tester);
    await _fillProject(tester);
    await _tapProjectSave(tester);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(logoutCount, 1);
    await _login(tester);
    expect(writeCount, 1);
    expect(_textFieldValue(tester, 0), 'Portfolio App');
    await _tapProjectSave(tester);
    expect(writeCount, 2);
    expect(find.text('Proyek berhasil ditambahkan!'), findsOneWidget);
  });

  testWidgets('403 leaves the draft and does not request another login', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app((request) async {
        if (request.url.path == '/api/v1/auth/token/') {
          return _json({'token': 'fixture-token'});
        }
        expect(request.url.path, '/api/v1/projects/');
        return http.Response('', 403);
      }),
    );
    await _openProjectForm(tester);
    await _fillProject(tester);
    await _tapProjectSave(tester);
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.textContaining('HTTP 403'), findsOneWidget);
    expect(_textFieldValue(tester, 0), 'Portfolio App');
  });

  testWidgets('login errors include status and logout restores guest actions', (
    tester,
  ) async {
    var logoutCount = 0;
    await tester.pumpWidget(
      _app((request) async {
        if (request.url.path == '/api/v1/auth/token/') {
          final payload = jsonDecode(request.body) as Map<String, dynamic>;
          return payload['username'] == 'owner'
              ? _json({'token': 'fixture-token'})
              : http.Response('Invalid credentials', 400);
        }
        expect(request.url.path, '/api/v1/auth/logout/');
        expect(request.headers['Authorization'], 'Token fixture-token');
        logoutCount++;
        return http.Response('', 204);
      }),
    );
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();
    expect(find.text('Username cannot be empty!'), findsOneWidget);
    expect(find.text('Password cannot be empty!'), findsOneWidget);
    await _login(tester, username: 'unknown');
    expect(find.textContaining('Login gagal (400)'), findsOneWidget);
    await _login(tester);
    expect(find.text('Logout'), findsOneWidget);

    await tester.ensureVisible(find.text('Logout'));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(logoutCount, 1);
    expect(find.text('Anda telah logout.'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
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

const _project = {
  'id': 'd885f64e-3049-4fec-8b6d-d7a7922af244',
  'title': 'Portfolio App',
  'description': 'A mobile portfolio application.',
  'tech_stack': 'Flutter, Dart',
  'project_url': 'https://example.com/project',
  'project_image_url': '',
};

http.Response _json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status);

MyApp _app([Future<http.Response> Function(http.Request)? handler]) => MyApp(
  apiClient: ApiClient(
    baseUrl: 'https://example.com',
    client: MockClient(
      handler ??
          (request) async {
            expect(request.url.path, '/api/v1/auth/token/');
            return _json({'token': 'fixture-token'});
          },
    ),
  ),
);

Future<void> _login(WidgetTester tester, {String username = 'owner'}) async {
  await _enterTextField(tester, 0, username);
  await _enterTextField(tester, 1, 'fixture-password');
  await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
  await tester.pumpAndSettle();
}

Future<void> _openProjectForm(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Tambah Proyek'));
  await tester.tap(find.text('Tambah Proyek'));
  await tester.pumpAndSettle();
  await _login(tester);
}

Future<void> _fillProject(
  WidgetTester tester, {
  String url = 'https://example.com/project',
}) async {
  await _enterTextField(tester, 0, 'Portfolio App');
  await _enterTextField(tester, 1, 'A mobile portfolio application.');
  await _enterTextField(tester, 2, 'Flutter, Dart');
  await _enterTextField(tester, 3, url);
}

Future<void> _tapProjectSave(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Save'));
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
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
  await tester.pumpWidget(_app());
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
