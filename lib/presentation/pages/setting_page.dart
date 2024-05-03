// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_segmented_control/material_segmented_control.dart';
// import 'package:real_estaye_app/core/lang/bloc/localaize_state.dart';
// import 'package:real_estaye_app/core/lang/bloc/localize_cubit.dart';
// import 'package:real_estaye_app/core/theme/app_theme.dart';
// import 'package:real_estaye_app/core/theme/bloc/apptheme_bloc.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Settings"),
//       ),
//       body: SafeArea(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             BlocBuilder<LocalizeCubit, ChangeLocaleState>(
//               builder: (context, state) {
//                 int selectedIndex = 0; // Default to English
//                 if (state.locale.languageCode == 'ar') {
//                   selectedIndex = 1;
//                 }

//                 return MaterialSegmentedControl(
//                   children: {
//                     0: GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<LocalizeCubit>(context)
//                             .changeLanguage('en');
//                       },
//                       child: const Text("🇺🇲 English"),
//                     ),
//                     1: GestureDetector(
//                       onTap: () {
//                         BlocProvider.of<LocalizeCubit>(context)
//                             .changeLanguage('ar');
//                       },
//                       child: const Text("🇮🇶 Arabic"),
//                     ),
//                   },
//                   unselectedColor: Colors.white70,
//                   selectedTextStyle: const TextStyle(color: Colors.black),
//                   unselectedTextStyle:
//                       const TextStyle(fontSize: 15, color: Colors.black),
//                   selectionIndex: selectedIndex,
//                 );
//               },
//             ),
//             BlocBuilder<AppThemeBloc, AppThemeState>(
//               builder: (context, state) {
//                 IconData iconData = Icons.sunny;

//                 if (state is LoadedThemeState) {
//                   if (state.themeData == appThemeData[AppThemee.blueDark]) {
//                     iconData = FontAwesomeIcons.moon;
//                   }
//                 }

//                 return IconButton(
//                   icon: Icon(iconData),
//                   onPressed: () {
//                     final appThemeBloc = BlocProvider.of<AppThemeBloc>(context);

//                     final currentTheme = appThemeBloc.state;
//                     if (currentTheme is LoadedThemeState) {
//                       if (currentTheme.themeData ==
//                           appThemeData[AppThemee.blueLight]) {
//                         appThemeBloc.add(
//                             const ThemeChangedEvent(theme: AppThemee.blueDark));
//                       } else {
//                         appThemeBloc.add(const ThemeChangedEvent(
//                             theme: AppThemee.blueLight));
//                       }
//                     }
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:real_estaye_app/core/lang/bloc/localaize_state.dart';
import 'package:real_estaye_app/core/lang/bloc/localize_cubit.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/theme/bloc/apptheme_bloc.dart';
import 'package:real_estaye_app/core/widgets/custom_language_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
    // required this.listeners,
  }) : super(key: key);
  // final Listeners listeners;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarBuild(context),
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 2,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   radius: 40,
                  //   backgroundImage: AssetImage('assets/images/dwam.png'),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Name",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Software Engineer',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 40,
              ),
              CustomLanguageButton(
                leadingIcon: Icons.language,
                buttonText: "Language",
                trailingWidget: Row(
                  children: [
                    SizedBox(
                      width: 180,
                      child: BlocBuilder<LocalizeCubit, ChangeLocaleState>(
                        builder: (context, state) {
                          int selectedIndex = 0; // Default to English
                          if (state.locale.languageCode == 'ar') {
                            selectedIndex = 1;
                          }

                          return MaterialSegmentedControl(
                            children: {
                              0: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<LocalizeCubit>(context)
                                      .changeLanguage('en');
                                },
                                child: const Text("🇺🇲 English"),
                              ),
                              1: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<LocalizeCubit>(context)
                                      .changeLanguage('ar');
                                },
                                child: const Text("🇮🇶 Arabic"),
                              ),
                            },
                            unselectedColor: Colors.white70,
                            selectedTextStyle:
                                const TextStyle(color: Colors.black),
                            unselectedTextStyle: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            selectionIndex: selectedIndex,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // CustomBiggerButton(
              //   leadingIcon: Icons.help_center,
              //   trailingIcon: Icons.play_arrow,
              //   buttonText: "Help Center".tr(context),
              //   onPressed: () {},
              // ),
              const SizedBox(
                height: 10,
              ),
              // Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(50.0),
              //         ),
              //         child: ElevatedButton(
              //           style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all(purpleColor),
              //           ),
              //           onPressed: () {
              //             BlocProvider.of<LoginLogoutBloc>(context)
              //                 .add(LogOutButtonPressedEvent());
              //           },
              //           child: Text("Logout"),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _appbarBuild(BuildContext context) {
    return AppBar(
      actions: [
        BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (context, state) {
            IconData iconData = Icons.sunny;

            if (state is LoadedThemeState) {
              if (state.themeData == appThemeData[AppThemee.blueDark]) {
                iconData = FontAwesomeIcons.moon;
              }
            }

            return IconButton(
              icon: Icon(iconData),
              onPressed: () {
                final appThemeBloc = BlocProvider.of<AppThemeBloc>(context);

                final currentTheme = appThemeBloc.state;
                if (currentTheme is LoadedThemeState) {
                  if (currentTheme.themeData ==
                      appThemeData[AppThemee.blueLight]) {
                    appThemeBloc.add(
                        const ThemeChangedEvent(theme: AppThemee.blueDark));
                  } else {
                    appThemeBloc.add(
                        const ThemeChangedEvent(theme: AppThemee.blueLight));
                  }
                }
              },
            );
          },
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Row(
        children: [
          Icon(
            FontAwesomeIcons.gear,
            color: Colors.blue,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
