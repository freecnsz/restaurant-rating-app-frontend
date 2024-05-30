import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/services/auth_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

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
    if (_emailController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
    } else if (!isValidEmail(_emailController.text)) {
      isValid = false;
      _showErrorSnackbar('Geçerli bir email adresi giriniz');
    }
    return isValid;
  }

  bool isValidEmail(String email) {
    // Define the email pattern
    String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  Future<void> _submitForgetPassword() async {
    if (_validateFields()) {
      await AuthenticationService.forgotPassword(_emailController.text)
          .then((value) => {
                if (value)
                  {
                    CustomSnackbar.show(
                      context,
                      'Şifre sıfırlama bağlantısı email adresinize gönderildi',
                      icon: Icons.check,
                      backgroundColor: Colors.green,
                    ),
                  }
                else
                  {
                    CustomSnackbar.show(
                      context,
                      'Şifre sıfırlama bağlantısı gönderilemedi. Lütfen tekrar deneyin',
                      icon: Icons.error,
                      backgroundColor: Colors.red,
                    ),
                  }
              });
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                const SizedBox(height: 15),
                                const Text(
                                  AppStrings.textWelcome,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w200,
                                      color: AppColors.primaryWhite,
                                      fontFamily: AppStrings.fontFamiliy),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  AppStrings.textRenewYourPassword,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextFormField(
                                cursorColor: AppColors.iconColor,
                                enableSuggestions: true,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: AppColors.primaryBlack),
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: AppColors.primaryWhite),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.primaryWhite,
                                    hintText: AppStrings.textEmail,
                                    hintStyle: TextStyle(
                                        color: AppColors.iconColor,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: AppStrings.fontFamiliy),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: AppColors.primaryWhite),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Rounded border
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      AppStrings.buttonBack,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppStrings.fontFamiliy,
                                          color: AppColors
                                              .seconderyYellow // Text color
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _submitForgetPassword();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Rounded border
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      AppStrings.buttonRenewPassword,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppStrings.fontFamiliy,
                                          color: AppColors
                                              .seconderyYellow // Text color
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
