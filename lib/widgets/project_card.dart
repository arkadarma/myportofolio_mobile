import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

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

  Future<void> _handleTap(BuildContext context) async {
    if (item.action == HomepageAction.logout) {
      final auth = context.read<AuthState>();
      if (!auth.isLoggedIn) {
        await ensureLoggedIn(context);
        return;
      }
      await auth.logout();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Anda telah logout.')));
      return;
    }

    if (item.action == HomepageAction.addProject &&
        !await ensureLoggedIn(context)) {
      return;
    }
    if (context.mounted) onTap();
  }

  @override
  Widget build(BuildContext context) {
    final showLogin =
        item.action == HomepageAction.logout &&
        !context.watch<AuthState>().isLoggedIn;
    final name = showLogin ? 'Login' : item.name;
    final description = showLogin ? 'Masuk ke portofolio.' : item.description;
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTap(context),
        child: Semantics(
          button: true,
          label: '$name. $description',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  showLogin ? Icons.login : item.icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(height: 6),
                Text(
                  name,
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
                  description,
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
