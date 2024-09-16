// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study/core/providers/providers.dart';
import 'package:ited_study/feature/auth/presentation/views/home_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/settings_screen.dart';

import '../../../../core/widgets/custom_navigation_item.dart';

class NavScreen extends ConsumerWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    List<Widget> screens = [
      HomeScreen(),
      SetttingsScreen(),
      SetttingsScreen(),
      SetttingsScreen(),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 40,
          right: 40,
        ),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromRGBO(181, 178, 178, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomNavigationItem(
                  index: 0,
                  currentIndex: currentIndex,
                  icon: "assets/images/home.png",
                ),
                CustomNavigationItem(
                  index: 1,
                  currentIndex: currentIndex,
                  icon: "assets/images/track.png",
                ),
                CustomNavigationItem(
                  index: 2,
                  currentIndex: currentIndex,
                  icon: "assets/images/lkasd.png",
                ),
                CustomNavigationItem(
                  index: 3,
                  currentIndex: currentIndex,
                  icon: "assets/images/profile.png",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
