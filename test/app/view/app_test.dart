import 'package:flutter_test/flutter_test.dart';
import 'package:snapfood/common/app.dart';
import 'package:snapfood/screens/auth/pages/login_page.dart';

void main() {
  group('App', () {
    testWidgets('renders LoginPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
