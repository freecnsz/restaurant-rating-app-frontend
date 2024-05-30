import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';
import 'package:restaurant_rating_frontend/services/place_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class EditRestaurantDetailsPage extends StatefulWidget {
  final PlaceModel placeModel;
  final int placeId;

  const EditRestaurantDetailsPage({
    Key? key,
    required this.placeModel,
    required this.placeId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditRestaurantDetailsPageState createState() =>
      _EditRestaurantDetailsPageState();
}

class _EditRestaurantDetailsPageState extends State<EditRestaurantDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.placeModel.name);
    _descriptionController =
        TextEditingController(text: widget.placeModel.description);
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descriptionController.text;

    await PlaceService.updatePlace(widget.placeId, name, description)
        .then((value) => {
              if (value)
                {
                  Navigator.of(context).maybePop(),
                  CustomSnackbar.show(context, "Mekan başarıyla güncellendi",
                      backgroundColor: Colors.green, icon: Icons.check_circle),
                }
              else
                {
                  Navigator.of(context).maybePop(),
                  CustomSnackbar.show(
                      context, "Mekan güncellenirken bir hata oluştu",
                      backgroundColor: Colors.red, icon: Icons.error),
                }
            });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: AppColors.seconderyYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text(
          "Restoran bilgilerini düzenle",
          style: TextStyle(
            fontFamily: AppStrings.fontFamiliy,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.iconColor,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Restoran Adı:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppStrings.fontFamiliy,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primaryWhite,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.seconderyYellow,
                  ),
                ),
                filled: true,
                fillColor: AppColors.primaryWhite,
              ),
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                color: AppColors.primaryBlack,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Açıklama:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: AppStrings.fontFamiliy,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.primaryWhite,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppColors.seconderyYellow,
                  ),
                ),
                filled: true,
                fillColor: AppColors.primaryWhite,
              ),
              style: const TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                color: AppColors.primaryBlack,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'İptal',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.butonYellow,
            ),
            onPressed: () {
              setState(() {
                _onSave();
              });
            },
            child: const Text('Kaydet',
                style: TextStyle(
                  color: AppColors.primaryWhite,
                  fontFamily: AppStrings.fontFamiliy,
                )),
          ),
        ],
      ),
    );
  }
}
