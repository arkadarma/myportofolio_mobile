import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

/// Navigation drawer shared by the portfolio screens.
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    super.key,
    required this.homePageBuilder,
    required this.projectListPageBuilder,
    required this.projectFormPageBuilder,
    required this.educationFormPageBuilder,
  });

  final WidgetBuilder homePageBuilder;
  final WidgetBuilder projectListPageBuilder;
  final WidgetBuilder projectFormPageBuilder;
  final WidgetBuilder educationFormPageBuilder;

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;
    final pageContext = Scaffold.of(context).context;
    return Drawer(
      semanticLabel: 'My Portfolio navigation',
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: FittedBox(
              alignment: Alignment.topLeft,
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: 256,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Portfolio',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Explore personal projects and experiences!',
                      maxLines: 2,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () => _openHome(context),
          ),
          ListTile(
            leading: const Icon(Icons.folder_open_outlined),
            title: const Text('Projects'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                pageContext,
                MaterialPageRoute(builder: projectListPageBuilder),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              Navigator.pop(context);
              if (!await ensureLoggedIn(pageContext) || !pageContext.mounted) {
                return;
              }
              Navigator.push(
                pageContext,
                MaterialPageRoute(builder: projectFormPageBuilder),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: educationFormPageBuilder),
              );
            },
          ),
          ListTile(
            leading: Icon(isLoggedIn ? Icons.logout : Icons.login),
            title: Text(isLoggedIn ? 'Logout' : 'Login'),
            onTap: () async {
              final auth = context.read<AuthState>();
              Navigator.pop(context);
              if (!isLoggedIn) {
                await ensureLoggedIn(pageContext);
                return;
              }

              await auth.logout();
              if (!pageContext.mounted) return;
              _openHome(pageContext);
              ScaffoldMessenger.of(pageContext)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Anda telah logout.')),
                );
            },
          ),
        ],
      ),
    );
  }

  void _openHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: homePageBuilder),
      (route) => false,
    );
  }
}
