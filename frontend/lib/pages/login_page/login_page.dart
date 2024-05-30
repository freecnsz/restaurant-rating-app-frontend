import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/models/base_model.dart';
import 'package:restaurant_rating_frontend/models/user_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/dashboard.dart';
import 'package:restaurant_rating_frontend/pages/forget_password_page/forget_password_page.dart';
import 'package:restaurant_rating_frontend/pages/login_page/components/custom_checkbox.dart';
import 'package:restaurant_rating_frontend/pages/register_page/user_register_page.dart';
import 'package:restaurant_rating_frontend/services/auth_service.dart';
import 'package:restaurant_rating_frontend/shared_preferences/jwt_preferences.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;
  bool _obscureText = true;
  bool _isLoading = false;

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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
    }
    return isValid;
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
                  height: 450,
                  width: 400,
                  decoration: BoxDecoration(
                    color: AppColors.seconderyYellow,
                    borderRadius: BorderRadius.circular(
                        30), // Adjust the value to change the roundness
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      AppStrings.textWelcome,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w200,
                                          color: AppColors.primaryWhite,
                                          fontFamily: AppStrings.fontFamiliy),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      AppStrings.textSignIn,
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                          ]),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: TextFormField(
                                      cursorColor: AppColors.iconColor,
                                      enableSuggestions: true,
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      autofocus: true,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          color: AppColors.primaryBlack),
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: AppColors.primaryWhite),
                                          ),
                                          filled: true,
                                          fillColor: AppColors.primaryWhite,
                                          hintText: AppStrings.textEmail,
                                          hintStyle: TextStyle(
                                              color: AppColors.iconColor,
                                              fontWeight: FontWeight.normal,
                                              fontFamily:
                                                  AppStrings.fontFamiliy),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            borderSide: BorderSide(
                                                color: AppColors.primaryWhite),
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Lütfen e-posta adresinizi giriniz!';
                                        }
                                        return null;
                                      }),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.email_outlined,
                                  color: AppColors.iconColor,
                                  size: 30,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 50,
                                  child: TextFormField(
                                    cursorColor: AppColors.iconColor,
                                    obscureText: _obscureText,
                                    enableSuggestions: true,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(
                                        color: AppColors.primaryBlack),
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          color: AppColors.iconColor,
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: AppColors.primaryWhite),
                                        ),
                                        filled: true,
                                        fillColor: AppColors.primaryWhite,
                                        hintText: AppStrings.textPassword,
                                        hintStyle: const TextStyle(
                                            color: AppColors.iconColor,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: AppStrings.fontFamiliy),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide: BorderSide(
                                              color: AppColors.primaryWhite),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.password_outlined,
                                  color: AppColors.iconColor,
                                  size: 30,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                const Text(
                                  AppStrings.textRememberMe,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryWhite,
                                    fontFamily: AppStrings.fontFamiliy,
                                  ),
                                ),
                                const SizedBox(width: 175),
                                CustomCheckbox(),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPasswordPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    AppStrings.textForgotPassword,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.primaryBlack,
                                        fontFamily: AppStrings.fontFamiliy),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: _isLoading
                                      ? null
                                      : () {
                                          _login(_emailController.text,
                                              _passwordController.text);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Rounded border
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: 78,
                                      height:
                                          25, // Set a fixed width for the button content
                                      child: _isLoading
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        AppColors
                                                            .seconderyYellow),
                                              ),
                                            )
                                          : const Center(
                                              child: Text(
                                                AppStrings.buttonSignIn,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      AppStrings.fontFamiliy,
                                                  color: AppColors
                                                      .seconderyYellow, // Text color
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  AppStrings.textNotMetYet,
                                  style: TextStyle(
                                      color: AppColors.primaryWhite,
                                      fontFamily: AppStrings.fontFamiliy),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserRegister(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    AppStrings.textSignUpWithDot,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(String email, String password) {
    if (!_validateFields()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    AuthenticationService.authenticate(email, password)
        .then((BaseModel<UserModel> user) {
      setState(() {
        _isLoading = false;
      });

      if (user.succeeded == false) {
        // Check if authentication failed
        CustomSnackbar.show(context, user.message ?? "Login failed",
            icon: Icons.error, backgroundColor: Colors.red);
        return; // Exit if login failed
      }

      // Save user details if authentication succeeded
      JwtPreferences.saveToken(user.user?.jwToken ?? '');
      UserPreferences.saveUserInfo(
        user.user?.userName ?? '',
        user.user?.email ?? '',
        user.user?.id ?? '',
        user.user?.placeId ?? 0,
        user.user?.cityId ?? 0,
      );

      CustomSnackbar.show(context, "Giriş başarılı",
          icon: Icons.check, backgroundColor: Colors.green);

      // Navigate to the DashboardPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    }).catchError((e) {
      setState(() {
        _isLoading = false;
      });

      // Handle errors and show error message
      CustomSnackbar.show(context, "Giriş başarısız oldu",
          icon: Icons.error, backgroundColor: Colors.red);
    });
  }
}
