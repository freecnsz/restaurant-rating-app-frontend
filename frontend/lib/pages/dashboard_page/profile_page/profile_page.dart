import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: AppColors.seconderyYellow,
                      height: 500,
                      width: 800,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundColor: AppColors.primaryWhite,
                                      child: Icon(
                                        Icons.restaurant,
                                        color: AppColors.iconColor,
                                        size: 50,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        SizedBox(height: 20),
                                        Text(
                                          'Restaurant Name',
                                          style: TextStyle(
                                            fontFamily: AppStrings.fontFamiliy,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryWhite,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Skor: 4.5',
                                          style: TextStyle(
                                            fontFamily: AppStrings.fontFamiliy,
                                            color: AppColors.iconColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.iconColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Add functionality to edit profile
                                          },
                                          child: const Text(
                                            'Düzenle',
                                            style: TextStyle(
                                              color: AppColors.primaryWhite,
                                              fontFamily:
                                                  AppStrings.fontFamiliy,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(
                                color: AppColors.primaryWhite,
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Açıklama',
                              style: TextStyle(
                                fontFamily: AppStrings.fontFamiliy,
                                fontSize: 20,
                                color: AppColors.primaryWhite,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Açılış: 09:00"),
                            const SizedBox(height: 10),
                            const Text("Kapanış: 22:00"),
                            const SizedBox(height: 10),
                            const Text("Adres: İstanbul"),
                            const SizedBox(height: 10),
                            const Text("Telefon: 1234567890"),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Center(
                child: Text(
              'Profilinin güncel olduğundan emin ol:)',
              style: TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryBlack,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
