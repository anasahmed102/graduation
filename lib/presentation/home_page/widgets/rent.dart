import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

class RentList extends StatelessWidget {
  const RentList({
    Key? key,
    required this.datal,
  }) : super(key: key);

  final List<RealEstateModel> datal;

  @override
  Widget build(BuildContext context) {
    // Filter rental properties
    final rentalProperties =
        datal.where((property) => property.type == "Rent").toList();

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rentalProperties.length,
        itemBuilder: (context, index) {
          final property = rentalProperties[index];

          return Card(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Image.network(
                      property.photo,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          "\$${property.price}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(IconlyLight.location),
                      Text(
                        datal[index].properyName,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.area_chart),
                      Text(
                        property.size,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.bed),
                      const Text(
                        "3",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.bathroom),
                      const Text(
                        "3",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
