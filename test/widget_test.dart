import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('shows the three profile cards and portfolio actions', (
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
  });

  testWidgets('action cards use distinct colors and show the required message', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final cards = tester.widgetList<Material>(find.byType(Material)).where(
      (material) => material.borderRadius == BorderRadius.circular(12),
    );
    expect(cards.map((card) => card.color).toSet(), hasLength(3));

    for (final action in ['Lihat Portofolio', 'Tambah Proyek', 'Logout']) {
      await tester.tap(find.text(action));
      await tester.pump(const Duration(milliseconds: 300));

      expect(
        find.text('Kamu telah menekan tombol $action!'),
        findsOneWidget,
      );
    }
  });
}
