// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<RealEstateModel> data;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20,
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox.fromSize(
                    child: Image.network(
                      data[index].photo,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 250,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text("${data[index].price} \$"),
                                ),
                                const Icon(IconlyBold.heart)
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    data[index].properyName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: AppTheme.secondryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Row(
                                children: [
                                  Icon(IconlyLight.location),
                                  Text(
                                    "Iraq Erbil",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            const Row(
                              children: [
                                Icon(IconlyLight.bag),
                                Text(
                                  "2 Bathrooms",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(Icons.bed),
                                Text(
                                  "3 Bedrooms",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
