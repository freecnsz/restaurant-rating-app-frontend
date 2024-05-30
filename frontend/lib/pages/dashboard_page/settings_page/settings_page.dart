import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';
import 'package:restaurant_rating_frontend/services/delete_user_service.dart';
import 'package:restaurant_rating_frontend/services/reset_password_service.dart';
import 'package:restaurant_rating_frontend/shared_preferences/jwt_preferences.dart';
import 'package:restaurant_rating_frontend/shared_preferences/user_preferences.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureTextOldPassword = true;
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmPassword = true;
  String userId = '';

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
    if (_oldPasswordController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
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

  Future<void> _loadUserInfo() async {
    await UserPreferences.getUserInfo().then((value) => {
          setState(() {
            userId = value['id']!;
          })
        });
  }

  Future<void> deleteUser() async {
    await _loadUserInfo();
    await DeleteUserService.deleteUser(userId).then((value) => {
          if (value)
            {
              UserPreferences.clearUserInfo(),
              // Clear navigation stack and navigate to login page
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              ),
              CustomSnackbar.show(context, "Hesabın başarıyla silindi.",
                  backgroundColor: Colors.green, icon: Icons.check)
            }
          else
            {
              Navigator.pop(context),
              CustomSnackbar.show(context, "Hesap silme başarısız oldu.",
                  backgroundColor: Colors.red, icon: Icons.error)
            }
        });
  }

  Future<void> _resetPassword() async {
    await _loadUserInfo();
    await ResetPasswordService.resetPassword(
      userId,
      _oldPasswordController.text,
      _passwordController.text,
    ).then((value) => {
          if (value)
            {
              CustomSnackbar.show(context, "Şifren başarıyla değiştirildi.",
                  backgroundColor: Colors.green, icon: Icons.check)
            }
          else
            {
              CustomSnackbar.show(context, "Şifre değiştirme başarısız oldu.",
                  backgroundColor: Colors.red, icon: Icons.error)
            }
        });
    _oldPasswordController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.seconderyYellow,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bu alanı kullanarak şifreni değiştirebilirsin.",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: AppStrings.fontFamiliy,
                          color: AppColors.primaryWhite,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(
                        thickness: 2,
                        color: AppColors.primaryWhite,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Eski şifre:",
                        style: TextStyle(
                          color: AppColors.iconColor,
                          fontFamily: AppStrings.fontFamiliy,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: _obscureTextOldPassword,
                        cursorColor: AppColors.iconColor,
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          suffixIcon: _obscureTextOldPassword
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextOldPassword = false;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: AppColors.iconColor),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextOldPassword = true;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_off,
                                      color: AppColors.iconColor),
                                ),
                          fillColor: AppColors.primaryWhite,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.primaryWhite),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.primaryWhite),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Yeni şifre:",
                        style: TextStyle(
                          color: AppColors.iconColor,
                          fontFamily: AppStrings.fontFamiliy,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: _obscureTextNewPassword,
                        cursorColor: AppColors.iconColor,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: _obscureTextNewPassword
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextNewPassword = false;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: AppColors.iconColor),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextNewPassword = true;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_off,
                                      color: AppColors.iconColor),
                                ),
                          fillColor: AppColors.primaryWhite,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.primaryWhite),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Yeni şifreyi onayla:",
                        style: TextStyle(
                          color: AppColors.iconColor,
                          fontFamily: AppStrings.fontFamiliy,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: _obscureTextConfirmPassword,
                        cursorColor: AppColors.iconColor,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          suffixIcon: _obscureTextConfirmPassword
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextConfirmPassword = false;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility,
                                      color: AppColors.iconColor),
                                )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscureTextConfirmPassword = true;
                                    });
                                  },
                                  icon: const Icon(Icons.visibility_off,
                                      color: AppColors.iconColor),
                                ),
                          fillColor: AppColors.primaryWhite,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.primaryWhite),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_validateFields()) {
                            _resetPassword();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.butonYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Şifremi değiştir",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontFamily: AppStrings.fontFamiliy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    thickness: 2,
                    color: AppColors.iconColor,
                    width: 32,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        width: 400,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.iconColor.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Aşağıdaki butona tıklayarak hesabını silebilirsin. Hesabını sildiğinde tüm bilgilerin silinecektir. Bu işlem geri alınamaz.",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: AppStrings.fontFamiliy,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: AppColors.seconderyYellow,
                                    title: const Text(
                                      "Hesabını silmek istediğine emin misin?",
                                      style: TextStyle(
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy,
                                      ),
                                    ),
                                    content: const Text(
                                      "Bu işlem geri alınamaz.",
                                      style: TextStyle(
                                        color: AppColors.primaryWhite,
                                        fontFamily: AppStrings.fontFamiliy,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "İptal",
                                          style: TextStyle(
                                            color: AppColors.primaryBlack,
                                            fontFamily: AppStrings.fontFamiliy,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await deleteUser();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text(
                                          "Hesabımı sil",
                                          style: TextStyle(
                                            color: AppColors.primaryWhite,
                                            fontFamily: AppStrings.fontFamiliy,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Hesabımı sil",
                          style: TextStyle(
                            color: AppColors.primaryWhite,
                            fontFamily: AppStrings.fontFamiliy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
