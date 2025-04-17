import 'package:flutter/widgets.dart';
import 'package:snapfood/common/widgets/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage();
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return child;
        }
        return child;
      },
    );
  }
}
