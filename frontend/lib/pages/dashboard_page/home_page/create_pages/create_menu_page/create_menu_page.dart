import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/models/menu_type_model.dart';
import 'package:restaurant_rating_frontend/pages/dashboard_page/home_page/create_pages/create_menu_page/components/menu_type_dropdown.dart';
import 'package:restaurant_rating_frontend/services/menu_service.dart';
import 'package:restaurant_rating_frontend/services/menu_type_service.dart';
import 'package:restaurant_rating_frontend/utils/custom_snackbar.dart';

class AddMenuDialog extends StatefulWidget {
  final int placeId;
  const AddMenuDialog({Key? key, required this.placeId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddMenuDialogState createState() => _AddMenuDialogState();
}

class _AddMenuDialogState extends State<AddMenuDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController menuTypeController = TextEditingController();

  late BaseMenuTypeModel menuTypeModel;
  List<MenuTypeModel> menuTypes = [];
  List<String> menuTypeNames = [];

  @override
  void initState() {
    super.initState();
    _fetchMenuTypes();
  }

  Future<void> _fetchMenuTypes() async {
    menuTypeModel = await MenuTypeService.getAllMenuTypes();
    setState(() {
      menuTypes = menuTypeModel.data!;
      menuTypeNames = menuTypes.map((e) => e.name!).toList();
    });
  }

  Future<void> _submitMenu() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        menuTypeController.text.isEmpty) {
      CustomSnackbar.show(context, 'Lütfen tüm alanları doldurun',
          backgroundColor: Colors.red, icon: Icons.error);
      return;
    }

    try {
      final String name = nameController.text;
      final String description = descriptionController.text;
      final int menuTypeId = menuTypes
          .firstWhere((element) => element.name == menuTypeController.text)
          .id!;
      await MenuService.createMenu(
              name, description, widget.placeId, menuTypeId)
          .then((value) => {
                if (value)
                  {
                    Navigator.of(context).maybePop(),
                    CustomSnackbar.show(context, 'Menü başarıyla eklendi',
                        backgroundColor: Colors.green, icon: Icons.check),
                  }
                else
                  {
                    CustomSnackbar.show(
                        context, 'Menü eklenirken bir hata oluştu',
                        backgroundColor: Colors.red, icon: Icons.error)
                  },
              });
    } catch (e) {
      CustomSnackbar.show(context, 'Menü eklenirken bir hata oluştu',
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
        'Menü ekle',
        style: TextStyle(
          color: AppColors.iconColor,
          fontFamily: AppStrings.fontFamiliy,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Menü Adı',
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
            const Text("Menü Tipi",
                style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontFamily: AppStrings.fontFamiliy)),
            MenuTypeDropdown(
                items: menuTypeNames,
                value: menuTypeNames.isEmpty ? null : menuTypeNames.first,
                onChanged: (String? value) {
                  setState(() {
                    menuTypeController.text = value!;
                  });
                }),
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
          onPressed: _submitMenu,
          child: const Text('Ekle',
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontFamily: AppStrings.fontFamiliy,
              )),
        ),
      ],
    );
  }
}
