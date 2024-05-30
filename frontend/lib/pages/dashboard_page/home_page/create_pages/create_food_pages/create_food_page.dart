import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/food_model.dart';
import 'package:restaurant_rating_frontend/models/food_type_model.dart';
import 'package:restaurant_rating_frontend/services/food_service.dart';
import 'package:restaurant_rating_frontend/services/food_type_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/create_pages/create_menu_page/components/menu_type_dropdown.dart';

class CreateFoodDialog extends StatefulWidget {
  final int menuId;
  const CreateFoodDialog({Key? key, required this.menuId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateFoodDialogState createState() => _CreateFoodDialogState();
}

class _CreateFoodDialogState extends State<CreateFoodDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController foodImageController = TextEditingController();
  final TextEditingController priceConroller = TextEditingController();
  final TextEditingController foodTypeIdController = TextEditingController();

  late FoodTypeModel foodTypeModel;
  List<FoodType> foodTypes = [];
  List<String> foodTypeNames = [];

  @override
  void initState() {
    super.initState();
    _fetchFoodTypes();
  }

  Future<void> _fetchFoodTypes() async {
    foodTypeModel = await FoodTypeService.getAllFoodTypes();
    setState(() {
      foodTypes = foodTypeModel.data!;
      foodTypeNames = foodTypes.map((e) => e.name!).toList();
    });
  }

  Future<void> _submitMenu() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceConroller.text.isEmpty ||
        foodTypeIdController.text.isEmpty) {
      CustomSnackbar.show(context, 'Lütfen tüm alanları doldurun',
          backgroundColor: Colors.red, icon: Icons.error);
      return;
    }

    double? price;
    try {
      price = double.parse(priceConroller.text);
    } catch (e) {
      CustomSnackbar.show(context, 'Lütfen geçerli bir fiyat girin',
          backgroundColor: Colors.red, icon: Icons.error);
      return;
    }

    final FoodModel foodModel = FoodModel(
      name: nameController.text,
      description: descriptionController.text,
      price: price,
      foodImage: foodImageController.text,
    );

    try {
      await FoodService.createFood(
        foodModel,
        int.parse(foodTypeIdController.text),
        widget.menuId,
      ).then((value) => {
            if (value)
              {
                Navigator.of(context).maybePop(),
                CustomSnackbar.show(context, 'Ürün başarıyla eklendi',
                    backgroundColor: Colors.green, icon: Icons.check),
              }
            else
              {
                CustomSnackbar.show(context, 'Ürün eklenirken bir hata oluştu',
                    backgroundColor: Colors.red, icon: Icons.error)
              },
          });
    } catch (e) {
      CustomSnackbar.show(context, 'Ürün eklenirken bir hata oluştu',
          backgroundColor: Colors.red, icon: Icons.error);
      Navigator.of(context).maybePop();
    }
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primaryYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Ürün ekle',
        style: TextStyle(
          color: AppColors.iconColor,
          fontFamily: AppStrings.fontFamiliy,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Ürün Adı',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(nameController),
            const SizedBox(height: 10),
            const Text(
              'Açıklama',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(descriptionController),
            const SizedBox(height: 10),
            const Text(
              'Resim URL:',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(foodImageController),
            const SizedBox(height: 10),
            const Text(
              'Fiyat:',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
            _buildTextField(priceConroller),
            const SizedBox(height: 10),
            const Text(
              'Ürün Tipi',
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontFamily: AppStrings.fontFamiliy,
              ),
            ),
            const SizedBox(height: 8),
            MenuTypeDropdown(
              items: foodTypeNames,
              value: foodTypeNames.isEmpty ? null : foodTypeNames.first,
              onChanged: (String? value) {
                setState(() {
                  foodTypeIdController.text = (foodTypes
                          .firstWhere((element) => element.name == value)
                          .id)
                      .toString();
                });
              },
            ),
          ],
        ),
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
          onPressed: (() {
            _submitMenu();
          }),
          child: const Text(
            'Ekle',
            style: TextStyle(
              color: AppColors.primaryWhite,
              fontFamily: AppStrings.fontFamiliy,
            ),
          ),
        ),
      ],
    );
  }
}
