import 'package:material_ui/material_ui.dart';

enum HomepageAction { portfolio, addProject, addEducation, logout }

/// Data model for a portfolio action, including copy and visual treatment.
class ItemHomepage {
  const ItemHomepage({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.action,
  });

  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final HomepageAction action;
}

/// Tappable portfolio action card; its parent owns the navigation behavior.
class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key, required this.onTap});

  final ItemHomepage item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Semantics(
          button: true,
          label: '${item.name}. ${item.description}',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 24),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
