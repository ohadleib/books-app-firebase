import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/model.dart';
import 'sreen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: LoginScreen(
        toggleTheme: toggleTheme,
        isDarkMode: isDarkMode,
      ), // Set LoginScreen as the home screen
    );
  }
}

List<Book> cart = [];
