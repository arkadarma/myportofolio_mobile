import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Main portfolio screen for the confirmed owner profile.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.drawer});

  final LeftDrawer drawer;

  static const List<ItemHomepage> items = [
    ItemHomepage(
      name: 'Lihat Portofolio',
      description: 'Jelajahi ringkasan profil dan karya.',
      icon: Icons.folder_open,
      color: Colors.indigo,
      action: HomepageAction.portfolio,
    ),
    ItemHomepage(
      name: 'Tambah Proyek',
      description: 'Catat proyek baru ke portofolio.',
      icon: Icons.add_circle_outline,
      color: Colors.teal,
      action: HomepageAction.addProject,
    ),
    ItemHomepage(
      name: 'Tambah Pendidikan',
      description: 'Tambahkan riwayat pendidikan.',
      icon: Icons.school_outlined,
      color: Colors.deepPurple,
      action: HomepageAction.addEducation,
    ),
    ItemHomepage(
      name: 'Logout',
      description: 'Akhiri sesi portofolio.',
      icon: Icons.logout,
      color: Colors.deepOrange,
      action: HomepageAction.logout,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: drawer,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 520;
            final crossAxisCount = constraints.maxWidth >= 900
                ? 4
                : constraints.maxWidth >= 600
                ? 3
                : 2;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Profil Pemilik',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                if (compact)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InfoCard(title: 'NPM', content: '2506656791'),
                      InfoCard(
                        title: 'Name',
                        content: 'I Komang Arka Darma Laksana',
                      ),
                      InfoCard(title: 'Class', content: 'PBP D'),
                    ],
                  )
                else
                  const Row(
                    children: [
                      Expanded(
                        child: InfoCard(title: 'NPM', content: '2506656791'),
                      ),
                      Expanded(
                        child: InfoCard(
                          title: 'Name',
                          content: 'I Komang Arka Darma Laksana',
                        ),
                      ),
                      Expanded(
                        child: InfoCard(title: 'Class', content: 'PBP D'),
                      ),
                    ],
                  ),
                const SizedBox(height: 28),
                Text(
                  'Aksi Portofolio',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Pilih salah satu menu untuk melanjutkan.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: 158,
                  shrinkWrap: true,
                  children: items
                      .map(
                        (item) => ItemCard(
                          item,
                          onTap: () => _openPage(context, item.action),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openPage(BuildContext context, HomepageAction action) {
    final WidgetBuilder? pageBuilder = switch (action) {
      HomepageAction.addProject => drawer.projectFormPageBuilder,
      HomepageAction.addEducation => drawer.educationFormPageBuilder,
      HomepageAction.portfolio => drawer.projectListPageBuilder,
      HomepageAction.logout => null,
    };
    if (pageBuilder != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.push(context, MaterialPageRoute(builder: pageBuilder));
    }
  }
}

/// Reusable card for a single profile field.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
