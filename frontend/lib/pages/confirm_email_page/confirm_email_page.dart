import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:restaurant_rating_frontend/services/confirm_email_service.dart'; // Import your service

class EmailConfirmationPage extends StatefulWidget {
  const EmailConfirmationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailConfirmationPageState createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  String _userId = '';
  String _code = '';
  bool _isConfirmed = false;
  String _message = "Hesabın onaylanıyor...";

  StreamSubscription<String?>? _linkSubscription;

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
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        handleIncomingLink(initialLink);
      }

      _linkSubscription = linkStream.listen((String? link) {
        if (link != null) {
          handleIncomingLink(link);
        }
      }, onError: (Object err) {
        // Handle error
      });
    } catch (e) {
      // Handle any errors that might occur
    }
  }

  void handleIncomingLink(String link) {
    final uri = Uri.parse(link);
    setState(() {
      _userId = uri.queryParameters['userId'] ?? '';
      _code = uri.queryParameters['code'] ?? '';
    });

    confirmEmail();
  }

  Future<void> confirmEmail() async {
    try {
      bool result = await ConfirmEmailService.confirmEmail(_userId, _code);
      setState(() {
        _isConfirmed = result;
        _message = _isConfirmed
            ? "Hesabını onayladın, artık giriş yapabilirsin. Seni giriş sayfasına yönlendiriyoruz."
            : "Hesabını onaylarken bir hata oluştu. Lütfen tekrar deneyin.";
      });
    } catch (e) {
      setState(() {
        _message =
            "Hesabını onaylarken bir hata oluştu. Lütfen tekrar deneyin.";
      });
    }

    // Redirect to login page after displaying the message
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
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
                    borderRadius: BorderRadius.circular(30),
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
                                Center(
                                  child: Text(
                                    _message,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryWhite,
                                      fontFamily: AppStrings.fontFamiliy,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: AppColors.primaryWhite,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.iconColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
