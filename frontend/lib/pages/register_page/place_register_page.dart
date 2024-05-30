import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/models/location_model.dart';
import 'package:restaurant_rating_frontend/models/place_type_model.dart';
import 'package:restaurant_rating_frontend/pages/login_page/login_page.dart';
import 'package:restaurant_rating_frontend/pages/register_page/components/custom_dropdown_menu.dart';
import 'package:restaurant_rating_frontend/pages/register_page/components/custom_text_form_field.dart';
import 'package:restaurant_rating_frontend/services/location_service.dart';
import 'package:restaurant_rating_frontend/services/place_type_service.dart';
import 'package:restaurant_rating_frontend/services/register_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class PlaceRegisterPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  const PlaceRegisterPage({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PlaceRegisterPageState createState() => _PlaceRegisterPageState();
}

class _PlaceRegisterPageState extends State<PlaceRegisterPage> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController =
      TextEditingController();
  final TextEditingController _placeAddressController = TextEditingController();
  final TextEditingController _placeCityController = TextEditingController();
  final TextEditingController _placeDistrictController =
      TextEditingController();
  final TextEditingController _placeTypeController = TextEditingController();

  List<Datum> types = [];
  List<City> cities = [];
  List<District> districts = [];

  List<String> placeTypes = [];
  List<String> cityNames = [];
  List<String> filteredCityNames = [];
  List<String> districtsNames = [];
  List<String> filteredDistrictsNames = [];
  bool isLoading = true;
  bool isDistrictsLoading = true;
  bool isTypeLoading = true;
  int selectedCityId = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllPlaceTypes();
    getAllCities();
  }

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
    if (_placeNameController.text.isEmpty ||
        _placeDescriptionController.text.isEmpty ||
        _placeAddressController.text.isEmpty) {
      isValid = false;
      _showErrorSnackbar('Tüm alanları doldurmanız gerekiyor');
    }
    return isValid;
  }

  Future<void> getAllPlaceTypes() async {
    try {
      types = await PlaceTypeService.getAllPlaceTypes();
      setState(() {
        placeTypes = types.map((e) => e.name!).toList();
        _placeTypeController.text = types.first.id.toString();
        isTypeLoading = false;
      });
    } catch (e) {
      setState(() {
        placeTypes.add("Hiçbir mekan türü bulunamadı");
      });
    }
  }

  Future<void> getAllCities() async {
    try {
      await LocationService.getAllCities().then((value) => {
            cities = value.data!,
            _placeCityController.text = cities.first.id.toString(),
          });

      setState(() {
        cityNames = cities.map((e) => e.name!).toList();
        filteredCityNames = cityNames;
        isLoading = false;
        if (cities.isNotEmpty) {
          getDistrictByCityId(cities.first.id!);
          _placeCityController.text = cities.first.id.toString();
        }
      });
    } catch (e) {
      setState(() {
        cityNames.add("Hiçbir şehir bulunamadı");
        filteredCityNames = cityNames;
        isLoading = false;
      });
    }
  }

  Future<void> getDistrictByCityId(int cityId) async {
    setState(() {
      isDistrictsLoading = true;
      selectedCityId = cityId;
    });
    try {
      await LocationService.getDistrictByCityId(cityId).then((value) => {
            districts = value.data!,
          });

      setState(() {
        districtsNames = districts.map((e) => e.name!).toList();
        filteredDistrictsNames = districtsNames;
        isDistrictsLoading = false;
      });
    } catch (e) {
      setState(() {
        districtsNames.add("Hiçbir ilçe bulunamadı");
        filteredDistrictsNames = districtsNames;
        isDistrictsLoading = false;
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
                  height:
                      520, // Increased height to accommodate filtering fields
                  width: 410,
                  decoration: BoxDecoration(
                    color: AppColors.seconderyYellow,
                    borderRadius: BorderRadius.circular(
                        30), // Adjust the value to change the roundness
                  ),
                  child: Form(
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
                                      AppStrings.textLetsAddYourPlace,
                                      style: TextStyle(
                                        fontSize: 23,
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
                          labelText: AppStrings.textPlaceName,
                          obscureText: false,
                          controller: _placeNameController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textPlaceDescription,
                          obscureText: false,
                          controller: _placeDescriptionController,
                        ),
                        const SizedBox(height: 15),
                        LabeledTextFormField(
                          mainAxisAlignment: MainAxisAlignment.end,
                          labelText: AppStrings.textPlaceAddress,
                          obscureText: false,
                          controller: _placeAddressController,
                        ),
                        const SizedBox(height: 15),
                        LabeledDropdownButton(
                          labelText: AppStrings.textPlaceCity,
                          items: isLoading ? [] : filteredCityNames,
                          value: isLoading || filteredCityNames.isEmpty
                              ? null
                              : filteredCityNames.first,
                          onChanged: (String? newValue) {
                            setState(() {
                              if (newValue != null) {
                                _placeCityController.text = cities
                                    .firstWhere(
                                        (element) => element.name == newValue)
                                    .id
                                    .toString();
                                getDistrictByCityId(
                                    int.parse(_placeCityController.text));
                              }
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        LabeledDropdownButton(
                          labelText: AppStrings.textPlaceDistrict,
                          items:
                              isDistrictsLoading ? [] : filteredDistrictsNames,
                          value: isDistrictsLoading ||
                                  filteredDistrictsNames.isEmpty
                              ? null
                              : filteredDistrictsNames.first,
                          onChanged: (String? newValue) {
                            setState(() {
                              _placeDistrictController.text = districts
                                  .firstWhere(
                                      (element) => element.name == newValue)
                                  .id
                                  .toString();
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        LabeledDropdownButton(
                          labelText: AppStrings.textPlaceType,
                          items: isTypeLoading ? [] : placeTypes,
                          value: isTypeLoading || placeTypes.isEmpty
                              ? null
                              : placeTypes.first,
                          onChanged: (String? newValue) {
                            setState(() {
                              _placeTypeController.text = types
                                  .firstWhere(
                                      (element) => element.name == newValue)
                                  .id
                                  .toString();
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        handleRegister();
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: _isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  AppColors.seconderyYellow),
                                        ),
                                      )
                                    : const Text(
                                        AppStrings.buttonSignUp,
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

  void handleRegister() {
    String errorMessage = "";
    if (_validateFields()) {
      setState(() {
        _isLoading = true;
      });

      try {
        int cityId = int.parse(_placeCityController.text);
        int districtId = int.parse(_placeDistrictController.text);
        int placeTypeId = int.parse(_placeTypeController.text);

        RegisterService.register(
          widget.firstName,
          widget.lastName,
          widget.email,
          widget.username,
          widget.password,
          widget.confirmPassword,
          _placeNameController.text,
          _placeDescriptionController.text,
          _placeAddressController.text,
          cityId,
          districtId,
          placeTypeId,
        ).then((value) {
          setState(() {
            _isLoading = false;
          });
          errorMessage = value.message ?? "Kayıt başarısız oldu";

          if (!value.succeeded!) {
            // Check if registration failed
            CustomSnackbar.show(
                context, value.message ?? "Kayıt başarısız oldu",
                icon: Icons.error, backgroundColor: Colors.red);
            return; // Exit if registration failed
          }

          // Inform the user to check their email for account confirmation
          CustomSnackbar.show(context,
              "Kayıt talebiniz alındı. Hesabınızı aktifleştirmek için e-postanızı kontrol edin.",
              icon: Icons.check, backgroundColor: Colors.green);

          // Optionally navigate to a page that tells the user to check their email or to the login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }).catchError((e) {
          setState(() {
            _isLoading = false;
          });

          // Handle errors and show error message
          CustomSnackbar.show(context, errorMessage,
              icon: Icons.error, backgroundColor: Colors.red);
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Handle the parsing error
        CustomSnackbar.show(context, errorMessage,
            icon: Icons.error, backgroundColor: Colors.red);
      }
    }
  }
}
