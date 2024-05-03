import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/favorites/favorites_bloc.dart';
import 'package:real_estaye_app/presentation/favorites/pages/favorites_page.dart';
import 'package:real_estaye_app/presentation/home_page/pages/home_page.dart';
import 'package:real_estaye_app/presentation/search_page/pages/search_page.dart';
import 'package:real_estaye_app/presentation/profile_page/pages/profile_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    BlocProvider.of<PostsBloc>(context).add(GetAllPostEvent());
    BlocProvider.of<FavoritesBloc>(context).add(GetAllFavoritesEvent());
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: _selectedIndex != 1
      //     ? MaterialButton(
      //         onPressed: () {
      //           handleLocationPermission(context);
      //         },
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(16)),
      //         color: Colors.blue,
      //         child: const Padding(
      //           padding: EdgeInsets.all(8.0),
      //           child: Text("Map"),
      //         ),
      //       )
      //     : ElevatedButton(
      //         onPressed: () {},
      //         child: const Text("Show Results"),
      //       ),
      body: PageView(
        controller: _pageController,
        children: _widgetOptions,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Home".tr(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Discovery'.tr(context),
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.book),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings'.tr(context),
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  // Future<void> handleLocationPermission(BuildContext context) async {
  //   final status = await Permission.location.status;

  //   if (status.isGranted) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (_) => const MapHrkn()),
  //     );
  //   } else if (status.isPermanentlyDenied) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("No Permission")));
  //   } else {
  //     final result = await Permission.location.request();

  //     if (result.isGranted) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const MapHrkn()),
  //       );
  //     } else if (result.isPermanentlyDenied) {
  //       openAppSettings();
  //     }
  //   }
  // }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePageClean(),
    const SearchPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];
}
