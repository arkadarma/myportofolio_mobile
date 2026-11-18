import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Main portfolio screen for the confirmed owner profile.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.drawer});

  final LeftDrawer drawer;

  static const List<ItemHomepage> items = [
    ItemHomepage('Lihat Portofolio', Icons.folder_open, Colors.indigo),
    ItemHomepage('Tambah Proyek', Icons.add_circle, Colors.teal),
    ItemHomepage('Logout', Icons.logout, Colors.deepOrange),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Profil Pemilik',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
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
              crossAxisCount: 3,
              childAspectRatio: 0.95,
              shrinkWrap: true,
              children: items
                  .map((item) => ItemCard(item, drawer: drawer))
                  .toList(),
            ),
          ],
        ),
      ),
    );
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
