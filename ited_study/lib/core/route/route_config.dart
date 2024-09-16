// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ited_study/feature/auth/presentation/views/change_password_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/edit_profile_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/forgot_password_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/login_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/sign_up_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/verification_screen.dart';
import 'package:ited_study/feature/gpa/presentation/calculate_cgpa_screen.dart';
import 'package:ited_study/feature/gpa/presentation/cgpa_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/about_us.dart';
import 'package:ited_study/feature/auth/presentation/views/nav_screen.dart';
import 'package:ited_study/views/onboarding_screen/onboarding_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/settings_screen.dart';

import '../../feature/auth/presentation/views/activate_app_screen.dart';
import '../../feature/auth/presentation/views/scholarship_screen.dart';
import 'route.dart';

final GoRouter router = GoRouter(
  initialLocation: '/navscreen',
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: OnboardingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.navscreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: NavScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.aboutus,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: AboutUs(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SetttingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.activate,
      pageBuilder: (context, state) => CustomTransitionPage(
          child: ActivateAppScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.forgotpassword,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ForgotPasswordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.cgpascreen,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: CGPAScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.verification,
      pageBuilder: (context, state) {
        final email = state.extra as String? ?? '';
        return CustomTransitionPage(
          key: state.pageKey,
          child: VerificationScreen(email: email),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: AppRoutes.calculatecgpa,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: CalculateCGPAScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.scholarship,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ScholarshipScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.editprofile,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: EditProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.changepassword,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ChangePasswordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
  ],
);
