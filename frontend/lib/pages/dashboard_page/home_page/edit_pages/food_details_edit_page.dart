import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/SingleFoodModel.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';
import 'package:restaurant_rating_frontend/services/food_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class EditFoodDetailsPage extends StatefulWidget {
  final int foodId;
  final ValueChanged<PlaceModel> onSave;

  const EditFoodDetailsPage({
    Key? key,
    required this.foodId,
    required this.onSave,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditFoodDetailsPageState createState() => _EditFoodDetailsPageState();
}

class _EditFoodDetailsPageState extends State<EditFoodDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _foodImageController = "";
  SingleFoodModel _foodModel = SingleFoodModel();

  @override
  void initState() {
    super.initState();
    getFoodById();
  }

  Future<void> getFoodById() async {
    await FoodService.getFoodById(widget.foodId).then((value) => {
          _foodModel = value,
        });
    setState(() {
      if (_foodModel.data != null) {
        _nameController.text = _foodModel.data!.name ?? "";
        _priceController.text = _foodModel.data!.price?.toString() ?? "";
        _descriptionController.text = _foodModel.data!.description ?? "";
        _foodImageController = _foodModel.data!.foodImage ?? "";
      }
    });
  }

  Future<void> _onSave() async {
    final id = _foodModel.data!.id;
    final name = _nameController.text;
    final price = double.parse(_priceController.text);
    final description = _descriptionController.text;
    final foodImage = _foodModel.data!.foodImage;
    await FoodService.updateFood(id!, name, description, foodImage!, price)
        .then((value) => {
              if (value)
                {
                  Navigator.of(context).pop(),
                  CustomSnackbar.show(context, "Ürün başarıyla güncellendi",
                      backgroundColor: Colors.green, icon: Icons.check_circle),
                }
              else
                {
                  CustomSnackbar.show(
                      context, "Ürün güncellenirken bir hata oluştu",
                      backgroundColor: Colors.red, icon: Icons.error),
                }
            });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.seconderyYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        "Ürün Düzenle",
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
            "Ürün adı:",
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
            "Fiyat:",
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
            controller: _priceController,
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
          const SizedBox(height: 16),
          const Text(
            "Ürün Resmi:",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: AppStrings.fontFamiliy,
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                _foodImageController,
                fit: BoxFit.cover,
              ))
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
            _onSave();
          },
          child: const Text('Kaydet',
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontFamily: AppStrings.fontFamiliy,
              )),
        ),
      ],
    );
  }
}
