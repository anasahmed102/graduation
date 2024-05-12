// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';

import '../../home_page/pages/new_details_page.dart';

class ListSearch extends StatelessWidget {
  const ListSearch({
    Key? key,
    required this.filteredData,
  }) : super(key: key);
  final List<RealEstateModel> filteredData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: filteredData.asMap().entries.map((entry) {
        final int index = entry.key;
        final RealEstateModel book = entry.value;

        List<Widget> bookWidgets = [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewDetailsPage(realEstate: book),
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: SizedBox(
                          height: 160,
                          width: 140,
                          child: Image.network(
                            book.photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0, bottom: 8),
                        child: Icon(
                          IconlyBold.heart,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "${book.price} \$",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          book.properyName,
                          style: const TextStyle(
                              color: AppTheme.secondryColor, fontSize: 15),
                        )),
                    const SizedBox(
                      height: 6,
                    ),
                    const Row(
                      children: [
                        Icon(Icons.place),
                        Text(
                          "32 park lorem ipsum",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 2.0),
                      child: Row(
                        children: [
                          Icon(Icons.area_chart),
                          SizedBox(
                            width: 5,
                          ),
                          Text("125"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.bed),
                          SizedBox(
                            width: 5,
                          ),
                          Text("2"),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.bedroom_baby),
                          SizedBox(
                            width: 5,
                          ),
                          Text("1")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          color: AppTheme.btn1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        MaterialButton(
                          onPressed: () {},
                          color: AppTheme.btn1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Email",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ];

        if (index < filteredData.length - 1) {
          bookWidgets.add(const Divider(
            thickness: 1,
          ));
        }

        return Column(
          children: bookWidgets,
        );
      }).toList(),
    );
  }
}
