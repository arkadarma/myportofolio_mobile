import 'package:material_ui/material_ui.dart';

/// Navigation drawer shared by the home and project form screens.
///
/// Page builders are supplied by the app root so this widget does not need
/// to import either screen and create a circular dependency.
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    super.key,
    required this.homePageBuilder,
    required this.projectFormPageBuilder,
  });

  final WidgetBuilder homePageBuilder;
  final WidgetBuilder projectFormPageBuilder;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: homePageBuilder),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: projectFormPageBuilder),
              );
            },
          ),
        ],
      ),
    );
  }
}
