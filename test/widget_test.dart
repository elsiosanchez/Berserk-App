import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:berserk_app/app.dart';

void main() {
  testWidgets('BerserkApp renders splash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: BerserkApp()),
    );
    expect(find.text('BERSERK'), findsOneWidget);
  });
}
