import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'intro_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/model.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  LoginScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userNameController.text.trim(),
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
      print("Login failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBookCarousel(),
              SizedBox(height: 20),
              _buildTextField(userNameController, 'Email'),
              SizedBox(height: 10),
              _buildTextField(passwordController, 'Password', obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(
                        toggleTheme: widget.toggleTheme,
                        isDarkMode: widget.isDarkMode,
                      ),
                    ),
                  );
                },
                child: Text("Don't have an account? Register"),
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

  Widget _buildBookCarousel() {
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context, index, realIndex) {
        final book = books[index];
        return _buildBookItem(book);
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(book.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
