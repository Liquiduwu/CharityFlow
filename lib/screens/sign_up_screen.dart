import 'package:flutter/material.dart';
import './auth_screen.dart'; // Import the AuthScreen
import './image_authentication_screen.dart'; // Import the new screen

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers to capture user input
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    String? userType;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
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
            Text("Register Your Information", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            // User Type Selection
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(value: "User", child: Text("User")),
                DropdownMenuItem(value: "Admin", child: Text("Admin")),
                DropdownMenuItem(value: "Courier", child: Text("Courier")),
              ],
              onChanged: (value) {
                userType = value;
              },
              decoration: InputDecoration(
                labelText: "Select User Type",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 20),
            // First Name Field
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
            // Last Name Field
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            // Phone Number Field
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            // Age Field
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Register Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary, // Use primary color from theme
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Validate input fields
                String email = emailController.text;
                String password = passwordController.text;
                String phone = phoneController.text;
                String age = ageController.text;

                if (firstNameController.text.isEmpty ||
                    lastNameController.text.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty ||
                    phone.isEmpty ||
                    age.isEmpty ||
                    userType == null) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in all fields."),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!email.contains('@')) {
                  // Validate email
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid email."),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]').hasMatch(password)) {
                  // Validate password
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password must contain both letters and numbers."),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!RegExp(r'^\d+$').hasMatch(phone)) {
                  // Validate phone number
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Phone number must be numeric."),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!RegExp(r'^\d+$').hasMatch(age)) {
                  // Validate age
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Age must be a number."),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  if (userType == "User") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImageAuthenticationScreen(),
                      ),
                    );
                  } else {
                    // Handle other user types
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  }
                }
              },
              child: Text("Register", style: TextStyle(color: Colors.white)), // Set text color to white
            ),
          ],
        ),
      ),
    );
  }
}
