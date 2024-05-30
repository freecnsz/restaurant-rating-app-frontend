import 'package:flutter/material.dart';
import 'package:restaurant_rating_frontend/constants/colors.dart';
import 'package:restaurant_rating_frontend/constants/strings.dart';
import 'package:restaurant_rating_frontend/constants/paths.dart';
import 'package:restaurant_rating_frontend/models/place_model.dart';

class ScoreboardWidget extends StatelessWidget {
  final List<PlaceModel> places;
  final Function(PlaceModel place) onPlaceSelected;

  const ScoreboardWidget({
    Key? key,
    required this.places,
    required this.onPlaceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: AppColors.seconderyYellow,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 80,
                height: 40,
                child: Image.asset(
                  Paths.pathLogo,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Puan Tablosu",
                style: TextStyle(
                  fontFamily: AppStrings.fontFamiliy,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryWhite,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset(
                    Paths.pathScoreIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Card(
                  color: AppColors.primaryWhite,
                  child: ListTile(
                    title: Text(
                      place.name ?? "Restoran ${index + 1}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.iconColor,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          place.description ?? "Açıklama yok",
                          style: const TextStyle(
                            fontFamily: AppStrings.fontFamiliy,
                            fontSize: 15,
                            color: AppColors.iconColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text("|",
                            style: TextStyle(color: AppColors.iconColor)),
                        const SizedBox(width: 10),
                        Text(place.districtName!,
                            style: const TextStyle(
                              fontFamily: AppStrings.fontFamiliy,
                              fontSize: 15,
                              color: AppColors.iconColor,
                            )),
                        const SizedBox(width: 10),
                        const Text("|",
                            style: TextStyle(color: AppColors.iconColor)),
                        const SizedBox(width: 10),
                        Text(
                          "Skor: ${place.ratePoint ?? (4.0 + index * 0.1)}",
                          style: const TextStyle(
                            fontFamily: AppStrings.fontFamiliy,
                            fontSize: 15,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                    leading: const Icon(
                      Icons.restaurant_rounded,
                      color: AppColors.iconColor,
                    ),
                    trailing: IconButton(
                      tooltip: "Restoranı görüntüle",
                      icon: const Icon(Icons.arrow_forward_ios_outlined),
                      color: AppColors.iconColor,
                      onPressed: () {
                        onPlaceSelected(place);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
