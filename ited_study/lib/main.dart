// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study/views/home_screen.dart';
import 'package:ited_study/views/nav_screen.dart';
import 'package:ited_study/views/onboarding_screen/onboarding_screen.dart';

import 'core/constants/colors.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: textTheme,
      ),
      home: OnboardingScreen(),
    );
  }
}
