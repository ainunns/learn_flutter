import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  void logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: const Text('Account Information'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Logged in as ${snapshot.data?.email}'),
                  const SizedBox(height: 24),
                  OutlinedButton(
                    onPressed: () => logout(context),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
