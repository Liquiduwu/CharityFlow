import 'package:flutter/material.dart';
import './User/home_screen.dart';
import './sign_up_screen.dart';
import './login_screen.dart'; // Import the LoginScreen

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to CharityFlow",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary, // Set text color to white
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            // Row for Sign In Buttons
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Primary color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Navigate to LoginScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Log In", style: TextStyle(fontSize: 18, color: Colors.white)), // Set text color to white
                ),
                const SizedBox(height: 20), // Space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary, // Secondary color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Navigate to SignUpScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)), // Set text color to white
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}