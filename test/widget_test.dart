import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamerpower_giveaways/main.dart';
import 'package:gamerpower_giveaways/models/giveaway.dart';
import 'package:gamerpower_giveaways/providers/giveaway_provider.dart';

void main() {
  testWidgets('App smoke test renders navigation and title', (WidgetTester tester) async {
    final mockGiveaways = [
      const Giveaway(
        id: 1,
        title: 'Test Game',
        worth: '\$19.99',
        thumbnail: '',
        image: '',
        description: 'Test Description',
        instructions: 'Test Instructions',
        openGiveawayUrl: 'https://example.com',
        publishedDate: '2026-01-01',
        type: 'Game',
        platforms: 'PC',
        endDate: '2026-12-31',
        users: 100,
        status: 'Active',
        gamerpowerUrl: 'https://example.com',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          giveawaysFutureProvider.overrideWith((ref) => Future.value(mockGiveaways)),
        ],
        child: const GamerPowerApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('GamerPower'), findsOneWidget);
    expect(find.text('Giveaways'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Test Game'), findsOneWidget);
  });
}
