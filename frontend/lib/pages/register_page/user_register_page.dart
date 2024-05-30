import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';
import 'package:restaurant_rating_frontend/pages/register_page/components/custom_text_form_field.dart';
import 'package:restaurant_rating_frontend/pages/register_page/place_register_page.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
    if (_nameController.text.isEmpty ||
        _surnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
    } else if (!isValidEmail(_emailController.text)) {
      isValid = false;
      _showErrorSnackbar('Geçerli bir email adresi giriniz');
    } else if (!doPasswordsMatch(
        _passwordController.text, _confirmPasswordController.text)) {
      isValid = false;
      _showErrorSnackbar('Şifreler uyuşmuyor');
    } else if (!isValidPassword(_passwordController.text)) {
      isValid = false;
      _showErrorSnackbar(
          'Şifre en az 8 karakter olmalı ve en az bir büyük harf, bir küçük harf, bir sayı ve bir özel karakter içermelidir');
    }
    return isValid;
  }

  bool isValidEmail(String email) {
    // Define the email pattern
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool doPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  bool isValidPassword(String password) {
    // Define the password pattern
    String passwordPattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])[A-Za-z\d@$!%*?&.]{8,}$";

    RegExp regex = RegExp(passwordPattern);
    return regex.hasMatch(password);
  }

  void _handleRegister() {
    if (_validateFields()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceRegisterPage(
            firstName: _nameController.text,
            lastName: _surnameController.text,
            email: _emailController.text,
            username: _usernameController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  Paths.pathLoginBackgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  height: 500,
                  width: 400,
                  decoration: BoxDecoration(
                    color: AppColors.seconderyYellow,
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Adjust the value to change the roundness
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 30),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: Image.asset(
                                  Paths.pathLogo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Text(
                                      AppStrings.textWelcome,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w100,
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      AppStrings.textJoinUs,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textYourName,
                          obscureText: false,
                          controller: _nameController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textSurname,
                          obscureText: false,
                          controller: _surnameController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textYourEmail,
                          obscureText: false,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textUsername,
                          obscureText: false,
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textYourPassword,
                          obscureText: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textConfirmPassword,
                          obscureText: true,
                          controller: _confirmPasswordController,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 125,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  AppStrings.buttonBack,
                                  style: TextStyle(
                                    color: AppColors.butonYellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppStrings.fontFamiliy,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: 125,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _handleRegister,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  AppStrings.buttonContinue,
                                  style: TextStyle(
                                    color: AppColors.butonYellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: AppStrings.fontFamiliy,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.textAlreadyMet,
                              style: TextStyle(
                                color: AppColors.primaryWhite,
                                fontSize: 15,
                                fontFamily: AppStrings.fontFamiliy,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                AppStrings.textSignInWithDot,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.primaryWhite,
                                  fontSize: 15,
                                  fontFamily: AppStrings.fontFamiliy,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
