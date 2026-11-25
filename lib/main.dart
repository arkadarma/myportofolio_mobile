import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.apiClient});

  final ApiClient apiClient;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LeftDrawer _drawer = LeftDrawer(
    homePageBuilder: (_) => MyHomePage(drawer: _drawer),
    projectListPageBuilder: (_) => ProjectListScreen(drawer: _drawer),
    projectFormPageBuilder: (_) => ProjectFormPage(drawer: _drawer),
    educationFormPageBuilder: (_) => EducationFormPage(drawer: _drawer),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.apiClient),
        ChangeNotifierProvider(create: (_) => AuthState(widget.apiClient)),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),
        home: MyHomePage(drawer: _drawer),
      ),
    );
  }
}
