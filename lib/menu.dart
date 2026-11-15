import 'package:flutter/material.dart';

/// Main portfolio screen for the confirmed owner profile.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                  child: InfoCard(
                    title: 'NPM',
                    content: '2506656791',
                  ),
                ),
                Expanded(
                  child: InfoCard(
                    title: 'Name',
                    content: 'I Komang Arka Darma Laksana',
                  ),
                ),
                Expanded(
                  child: InfoCard(
                    title: 'Class',
                    content: 'PBP D',
                  ),
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
              children: items.map((item) => ItemCard(item)).toList(),
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

/// Data model for one portfolio action, including its visual color.
class ItemHomepage {
  const ItemHomepage(this.name, this.icon, this.color);

  final String name;
  final IconData icon;
  final Color color;
}

/// Tappable portfolio action card that displays its own SnackBar message.
class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key});

  final ItemHomepage item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
              ),
            );
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
