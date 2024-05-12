// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/posts/data/model/real_estate.dart';
import 'package:real_estaye_app/presentation/search_page/widgets/list.dart';

final _searchController = TextEditingController();
int selectedButtonIndex = 0;
int _selectedType = 0;
int _selectedType2 = 0;
int _selectedValue = 0;
String selectedFrom = 'Min';
String selectedTo = 'Max';
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];

List<String> sizes = [
  "Min",
  '50M',
  '100M',
  '150M',
  '200M',
  '250M',
  '300M',
  '350M',
  '400M',
  '450M',
  '500M',
  '550M',
  '600M',
  '650M',
  '700M',
  '750M',
  '800M',
  '850M',
  '900M',
  '950M',
  '1000M',
  "Max",
];
String? selectedValue;
double _startValue = 0.0;
double _endValue = 100;
int _minPrice = 100;
int _maxPrice = 50000;

class NewSeearchPage extends StatefulWidget {
  const NewSeearchPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final List<RealEstateModel> data;

  @override
  _NewSeearchPageState createState() => _NewSeearchPageState();
}

class _NewSeearchPageState extends State<NewSeearchPage> {
  List<RealEstateModel> filteredData = [];

  @override
  void initState() {
    super.initState();
    _selectedType = -1; // No option selected initially
    selectedFrom = 'Min';
    selectedTo = 'Max';
    filterData(); // Apply initial filter
  }

  void filterData() {
    if (selectedFrom == 'Min' && selectedTo == 'Max') {
      setState(() {
        filteredData = List.from(widget.data);
      });
    } else {
      setState(() {
        filteredData.clear();
        filteredData.addAll(widget.data.where((data) {
          int dataSize = int.parse(data.size.replaceAll('M', ''));
          int fromSize = selectedFrom == 'Min'
              ? int.parse(sizes.first.replaceAll('M', ''))
              : int.parse(selectedFrom.replaceAll('M', ''));
          int toSize = selectedTo == 'Max'
              ? int.parse(sizes.last.replaceAll('M', ''))
              : int.parse(selectedTo.replaceAll('M', ''));
          return dataSize >= fromSize && dataSize <= toSize;
        }).toList());
      });
    }
  }

  void filterByType() {
    if (_selectedType != -1) {
      setState(() {
        filteredData = widget.data
            .where((realEstate) =>
                (realEstate.type == 'Rent' && _selectedType == 0) ||
                (realEstate.type == 'Buy' && _selectedType == 1))
            .toList();
      });
    }
  }

  void filterByTypeOf() {
    if (_selectedType2 != -1) {
      setState(() {
        filteredData = widget.data
            .where((realEstate) =>
                (realEstate.typeOfProperty == 'House' && _selectedType2 == 0) ||
                (realEstate.typeOfProperty == 'Apartment' &&
                    _selectedType2 == 1) ||
                (realEstate.typeOfProperty == 'Villa' && _selectedType2 == 2))
            .toList();
      });
    }
  }

  void filterByPrice(int minPrice, int maxPrice) {
    if (minPrice != 100 || maxPrice != 50000) {
      setState(() {
        filteredData = filteredData
            .where((realEstate) =>
                int.parse(realEstate.price) >= minPrice &&
                int.parse(realEstate.price) <= maxPrice)
            .toList();
      });
    }
  }

  void handleSubmit() {
    filterData();
    filterByType();
    filterByPrice(_minPrice, _maxPrice);
    filterByTypeOf();
  }

  void filterSearchResults(String query) {
    List<RealEstateModel> searchResults = widget.data.where((realEstate) {
      return realEstate.properyName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredData = searchResults;
    });
  }

  void resetFilter() {
    setState(() {
      filteredData = List.from(widget.data);
      _selectedType = -1;
      _selectedType2 = -1;
      _minPrice = 100;
      _maxPrice = 50000;
      selectedFrom = 'Min';
      selectedTo = 'Max';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search".tr(context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Search...".tr(context)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return FractionallySizedBox(
                                  heightFactor: 0.62,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 1,
                                        width: 50,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 30),
                                      const Text(
                                        "Filters",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Radio(
                                            value: 0,
                                            groupValue: _selectedType,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType = value!;
                                              });
                                            },
                                          ),
                                          const Text('Rent'),
                                          Radio(
                                            value: 1,
                                            groupValue: _selectedType,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType = value!;
                                              });
                                            },
                                          ),
                                          const Text('Buy'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Property type",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Radio(
                                            value: 0,
                                            groupValue: _selectedType2,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType2 = value!;
                                              });
                                            },
                                          ),
                                          const Text('House'),
                                          Radio(
                                            value: 1,
                                            groupValue: _selectedType2,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType2 = value!;
                                              });
                                            },
                                          ),
                                          const Text('Apartment'),
                                          const SizedBox(width: 20),
                                          Radio(
                                            value: 2,
                                            groupValue: _selectedType2,
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedType2 = value!;
                                              });
                                            },
                                          ),
                                          const Text('Villa'),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Size",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          DropdownButton<String>(
                                            value: selectedFrom,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedFrom = newValue!;
                                              });
                                            },
                                            items: sizes
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          const Text('from'),
                                          DropdownButton<String>(
                                            value: selectedTo,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedTo = newValue!;
                                              });
                                            },
                                            items: sizes
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                          const Text('to'),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Price",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            RangeSlider(
                                              values: RangeValues(
                                                  _minPrice.toDouble(),
                                                  _maxPrice.toDouble()),
                                              min: 100,
                                              max: 50000,
                                              divisions: 1000,
                                              labels: RangeLabels(
                                                _minPrice.toString(),
                                                _maxPrice.toString(),
                                              ),
                                              onChanged: (RangeValues values) {
                                                setState(() {
                                                  _minPrice =
                                                      values.start.toInt();
                                                  _maxPrice =
                                                      values.end.toInt();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            onPressed: resetFilter,
                                            color: AppTheme.btn1,
                                            child: Text(
                                              "Reset".tr(context),
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            onPressed: () {
                                              handleSubmit();
                                            },
                                            color: AppTheme.secondryColor,
                                            child: Text("Submit".tr(context)),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        IconlyBold.filter,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Suggested".tr(context),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListSearch(
              filteredData: filteredData,
            ),
          ]),
    ));
  }
}
