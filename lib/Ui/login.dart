import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/login_provider.dart';
import 'homescreen.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (authProvider.errorMessage != null)
              Text(
                authProvider.errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await authProvider.login(
                  emailController.text,
                  passwordController.text,
                );

                if (authProvider.user != null) {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (context) => const HomeScreen()), (
                      route) => false);
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
