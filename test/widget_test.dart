import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamerpower_giveaways/main.dart';

void main() {
  testWidgets('App smoke test renders navigation and title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GamerPowerApp(),
      ),
    );

    expect(find.text('GamerPower Giveaways'), findsOneWidget);
    expect(find.text('Giveaways'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
