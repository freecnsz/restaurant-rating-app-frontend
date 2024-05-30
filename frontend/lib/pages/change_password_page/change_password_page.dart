import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/services/reset_password_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';
import 'package:uni_links/uni_links.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _passwordsMatch = false;
  StreamSubscription<String?>? _linkSubscription;
  String _code = '';

  void _showErrorSnackbar(String message) {
    CustomSnackbar.show(
      context,
      message,
      icon: Icons.error,
      backgroundColor: Colors.red,
    );
  }

  bool _validateFields() {
    bool isValid = true;
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
    } else if (!isValidPassword(_passwordController.text)) {
      isValid = false;
      _showErrorSnackbar(
          'Şifre en az 8 karakter olmalı ve en az bir büyük harf, bir küçük harf, bir sayı ve bir özel karakter içermelidir');
    }
    return isValid;
  }

  bool isValidPassword(String password) {
    // Define the password pattern
    String passwordPattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])[A-Za-z\d@$!%*?&.]{8,}$";

    RegExp regex = RegExp(passwordPattern);
    return regex.hasMatch(password);
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {
    //   try {
    //     final initialLink = await getInitialLink();
    //     if (initialLink != null) {
    //       handleIncomingLink(initialLink);
    //     }

    //     _linkSubscription = linkStream.listen((String? link) {
    //       if (link != null) {
    //         handleIncomingLink(link);
    //       }
    //     }, onError: (Object err) {
    //       // Handle error
    //     });
    //   } catch (e) {
    //     // Handle any errors that might occur
    //   }
    // }

    // void handleIncomingLink(String link) {
    //   final uri = Uri.parse(link);
    //   setState(() {
    //     _code = uri.queryParameters['code'] ?? '';
    //   });

    resetPassword();
  }

  Future<void> resetPassword() async {
    if (_validateFields()) {
      try {
        await ResetPasswordService.resetPasswordForget(
                _emailController.text,
                _code,
                _passwordController.text,
                _confirmPasswordController.text)
            .then((value) => {
                  if (value)
                    {
                      CustomSnackbar.show(
                        context,
                        'Şifre değiştirme başarılı',
                        icon: Icons.check,
                        backgroundColor: Colors.green,
                      ),
                    }
                  else
                    {
                      CustomSnackbar.show(
                        context,
                        'Şifre değiştirme başarısız',
                        icon: Icons.error,
                        backgroundColor: Colors.red,
                      ),
                    }
                });
      } catch (e) {
        _showErrorSnackbar('Şifre değiştirme başarısız oldu: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryYellow,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.seconderyYellow,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset(
                        Paths.pathLogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'Şifreni yenile',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppStrings.fontFamiliy,
                      color: AppColors.primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColors.iconColor,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: AppColors.primaryBlack),
                    controller: _emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      filled: true,
                      fillColor: AppColors.primaryWhite,
                      hintText: "E-posta",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColors.iconColor,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: AppColors.primaryBlack),
                    controller: _passwordController,
                    obscureText: _obscureText1,
                    onChanged: (_) => _checkPasswordsMatch(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: AppColors.iconColor,
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      filled: true,
                      fillColor: AppColors.primaryWhite,
                      hintText: "Yeni şifre",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    cursorColor: AppColors.iconColor,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: AppColors.primaryBlack),
                    controller: _confirmPasswordController,
                    obscureText: _obscureText2,
                    onChanged: (_) => _checkPasswordsMatch(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: AppColors.iconColor,
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      filled: true,
                      fillColor: AppColors.primaryWhite,
                      hintText: "Şifreni onayla",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.primaryWhite),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      backgroundColor: AppColors.butonYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _passwordsMatch
                        ? () {
                            _validateFields();
                          }
                        : null,
                    child: const Text('Şifreni yenile',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: AppStrings.fontFamiliy,
                            color: AppColors.primaryWhite)),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Şiren en az 8 karakter olmalı, büyük harf, küçük harf, rakam ve özel karakter içermelidir.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: AppStrings.fontFamiliy,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkPasswordsMatch() {
    String newPassword = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    setState(() {
      _passwordsMatch =
          newPassword == confirmPassword && newPassword.isNotEmpty;
    });
  }
}
