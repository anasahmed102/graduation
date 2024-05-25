import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_estaye_app/core/const.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/but_list.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/list_home.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/rent.dart';
import 'package:real_estaye_app/presentation/home_page/widgets/vertical_list.dart';

class PropertWidget extends StatefulWidget {
  final List<RealEstateModel> realEstae;

  const PropertWidget({Key? key, required this.realEstae}) : super(key: key);

  @override
  State<PropertWidget> createState() => _PropertWidgetState();
}

class _PropertWidgetState extends State<PropertWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _appbarBuild(context),
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    final rentalProperties =
        widget.realEstae.where((property) => property.type == "Rent").toList();
    final buy =
        widget.realEstae.where((property) => property.type == "Buy").toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
            ),
            items: imageSliders,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Featured Unit",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextButton(
                  child: const Text(
                    "View More",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListHome(
                          filteredData: widget.realEstae,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          // Stack(children: [Image.network(widget.realEstae[index].photo)],),
          VerticalList(
            data: widget.realEstae,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Rent",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextButton(
                    child: const Text(
                      "View More",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondryColor),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListHome(
                            filteredData: rentalProperties,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
          RentList(
            datal: widget.realEstae,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Buy",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextButton(
                  child: const Text(
                    "View More",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondryColor),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListHome(
                          filteredData: buy,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          BuyList(
            datal: widget.realEstae,
          ),
        ],
      ),
    );
  }
}
