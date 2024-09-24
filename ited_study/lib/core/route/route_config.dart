// ignore_for_file: prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
import 'package:ited_study/feature/notes/presentation/views/course_note_screen.dart';
import 'package:ited_study/feature/notes/presentation/views/notes_screen.dart';
import 'package:ited_study/onboarding_screen/onboarding_screen.dart';
import 'package:ited_study/feature/auth/presentation/views/settings_screen.dart';
import '../../feature/auth/presentation/views/activate_app_screen.dart';
import '../../feature/auth/presentation/views/scholarship_screen.dart';
import '../../feature/notes/presentation/views/course_screen.dart';
import 'route.dart';

final box = Hive.box('sessionBox');
final isLoggedIn = box.get("isLoggedIn", defaultValue: false);

final router = GoRouter(
  initialLocation: isLoggedIn ? AppRoutes.navscreen : AppRoutes.onboarding,
  routes: [
    GoRoute(
      name: "/onboarding",
      path: AppRoutes.onboarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
        name: '/navscreen',
        path: AppRoutes.navscreen,
        builder: (context, state) => NavScreen()),
    GoRoute(
        name: '/aboutus',
        path: AppRoutes.aboutus,
        builder: (context, state) => AboutUs()),
    GoRoute(
      name: '/settings',
      path: AppRoutes.settings,
      builder: (context, state) => SetttingsScreen(),
    ),
    GoRoute(
      name: '/login',
      path: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: '/activate',
      path: AppRoutes.activate,
      builder: (context, state) => ActivateAppScreen(),
    ),
    GoRoute(
      name: '/signup',
      path: AppRoutes.signUp,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      name: '/forgotpassword',
      path: AppRoutes.forgotpassword,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      name: '/cgpa',
      path: AppRoutes.cgpascreen,
      builder: (context, state) => CGPAScreen(),
    ),
    GoRoute(
      name: '/verification',
      path: AppRoutes.verification,
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return VerificationScreen(email: email);
      },
    ),
    GoRoute(
      name: '/calculatecgpa',
      path: AppRoutes.calculatecgpa,
      builder: (context, state) => CalculateCGPAScreen(),
    ),
    GoRoute(
      name: 'scholarship',
      path: AppRoutes.scholarship,
      builder: (context, state) => ScholarshipScreen(),
    ),
    GoRoute(
      name: 'editprofile',
      path: AppRoutes.editprofile,
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      name: 'changepassword',
      path: AppRoutes.changepassword,
      builder: (context, state) => ChangePasswordScreen(),
    ),
    GoRoute(
      name: '/course',
      path: AppRoutes.course,
      builder: (context, state) => CourseScreen(),
    ),
    GoRoute(
      name: '/note',
      path: AppRoutes.note,
      builder: (context, state) => NotesScreen(),
    ),
    GoRoute(
      name: '/coursenote',
      path: AppRoutes.coursenote,
      builder: (context, state) => CourseNoteScreen(),
    ),
  ],
);
