// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 4, 45, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Contact Us",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Text("ABOUT US"),
            Text("Get to know more about ITed Education Software"),
            Text("The App"),
            Text(
              "The App Ited Educational Software offers interactive lessons, access to e-books, and quizzes to evaluate knowledge. It personalizes learning with adaptive lessons, progress tracking, and tailored recommendations.",
            ),
            Text("Vision"),
            Text(
              "The App Ited Educational Software offers interactive lessons, access to e-books, and quizzes to evaluate knowledge. It personalizes learning with adaptive lessons, progress tracking, and tailored recommendations.",
            ),
            Text("Mision"),
            Text(
              "The App Ited Educational Software offers interactive lessons, access to e-books, and quizzes to evaluate knowledge. It personalizes learning with adaptive lessons, progress tracking, and tailored recommendations.",
            ),
          ],
        ),
      ),
    );
  }
}
