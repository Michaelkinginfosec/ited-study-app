// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobileAndIpad;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.mobileAndIpad,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 1024) {
        return mobileAndIpad;
      } else {
        return desktop;
      }
    });
  }
}
