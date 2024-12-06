import 'package:flutter/material.dart';
import './Admin/admin_home_screen.dart';
import './User/home_screen.dart'; // Import the HomeScreen
import './Courier/courier_home_screen.dart'; // Import the CourierHomeScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers to capture user input
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the AuthScreen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Your Credentials",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Email Field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            // Password Field
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Row for Login Buttons
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Primary color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Validate input fields
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || !email.contains('@')) {
                      // Show error message for invalid email
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter a valid email."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (password.isEmpty) {
                      // Show error message for empty password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter your password."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Navigate to AdminHomeScreen
                      print("Logging in as Admin");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
                      );
                    }
                  },
                  child: const Text("Log In as Admin", style: TextStyle(color: Colors.white, fontSize: 16)), // White text
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary, // Secondary color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Validate input fields
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || !email.contains('@')) {
                      // Show error message for invalid email
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter a valid email."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (password.isEmpty) {
                      // Show error message for empty password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter your password."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Handle Courier login logic here
                      print("Logging in as Courier");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const CourierHomeScreen()), // Navigate to CourierHomeScreen
                      );
                    }
                  },
                  child: const Text("Log In as Courier", style: TextStyle(color: Colors.white, fontSize: 16)), // White text
                ),
                const SizedBox(height: 10), // Space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Primary color
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Validate input fields
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || !email.contains('@')) {
                      // Show error message for invalid email
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter a valid email."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (password.isEmpty) {
                      // Show error message for empty password
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please enter your password."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Handle User login logic here
                      print("Logging in as User");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                  child: const Text("Log In as User", style: TextStyle(color: Colors.white, fontSize: 16)), // White text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}