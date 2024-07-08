import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'intro_screen.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  RegisterScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IntroScreen(
            isDarkMode: widget.isDarkMode,
            toggleTheme: widget.toggleTheme,
          ),
        ),
      );
    } catch (e) {
      print("Registration failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(userNameController, 'UserName'),
              SizedBox(height: 10),
              _buildTextField(emailController, 'Email'),
              SizedBox(height: 10),
              _buildTextField(passwordController, 'Password', obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
