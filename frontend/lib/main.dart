import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/pages/change_password_page/change_password_page.dart';
import 'package:restaurant_rating_frontend/pages/confirm_email_page/confirm_email_page.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "confirmEmailPage": (context) => const EmailConfirmationPage(),
        "changePasswordPage": (context) => const ChangePasswordPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/changePasswordPage") {
          return MaterialPageRoute(
              builder: (context) => const ChangePasswordPage());
        } else if (settings.name == "/confirmEmailPage") {
          return MaterialPageRoute(
              builder: (context) => const EmailConfirmationPage());
        }
      },
      debugShowCheckedModeBanner: false,
      title: AppStrings.titleLoginPage,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
