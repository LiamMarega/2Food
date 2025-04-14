import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapfood/screens/auth/pages/google_signup_page.dart';
import 'package:snapfood/screens/auth/pages/login_page.dart';
import 'package:snapfood/screens/auth/pages/signin_page.dart';
import 'package:snapfood/screens/auth/pages/singup_page.dart';
import 'package:snapfood/screens/auth/pages/welcome_page.dart';

final authRoutes = [
  GoRoute(
    path: '/auth',
    redirect: (context, state) => '/auth/welcome',
  ),
  GoRoute(
    path: '/auth/welcome',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const WelcomePage(),
    ),
  ),
  GoRoute(
    path: '/auth/signin',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const SigninPage(),
    ),
  ),
  GoRoute(
    path: '/auth/login',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const LoginPage(),
    ),
  ),
  GoRoute(
    path: '/auth/signup',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const SignupPage(),
    ),
  ),
  GoRoute(
    path: '/auth/google-signup',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const GoogleSignupPage(),
    ),
  ),
];
