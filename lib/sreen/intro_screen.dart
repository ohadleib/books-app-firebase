import 'package:flutter/material.dart';

import '../model/model.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  IntroScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "ברוכים הבאים לאפליקציית הספרים הגדולה ביותר",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GridTile(
                    child: Image.asset(book.imageURL, fit: BoxFit.cover),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(book.title, textAlign: TextAlign.center),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      toggleTheme: widget.toggleTheme,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                );
              },
              child: Text("היכנס לעמוד הבית",
              style: TextStyle(color: widget.isDarkMode ?
               Colors.white : Colors.black,
               fontWeight: FontWeight.bold
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
