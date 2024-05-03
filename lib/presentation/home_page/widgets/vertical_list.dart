// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      child: Image.network(
                        data[index].photo,
                        width: 250,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("2000000"),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 0, bottom: 8, left: 2, right: 8),
                      child: Row(
                        children: [
                          Icon(Icons.place),
                          Text("Erbil Bakhtyary"),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(top: 0, bottom: 8, left: 2, right: 8),
                      child: Row(
                        children: [
                          Icon(Icons.place),
                          Text("Rooms"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
