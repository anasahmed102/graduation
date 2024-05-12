import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/theme/bloc/apptheme_bloc.dart';

class PopUpNotificationCard extends StatefulWidget {
  const PopUpNotificationCard({super.key});

  @override
  State<PopUpNotificationCard> createState() => _PopUpNotificationCardState();
}

class _PopUpNotificationCardState extends State<PopUpNotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AppTheme".tr(context),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AppThemeBloc, AppThemeState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          DayNightSwitcherIcon(
                            isDarkModeEnabled: state is LoadedThemeState &&
                                state.themeData ==
                                    appThemeData[AppThemee.blueDark],
                            onStateChanged: (isDarkModeEnabled) {
                              final appThemeBloc =
                                  BlocProvider.of<AppThemeBloc>(context);
                              if (isDarkModeEnabled) {
                                appThemeBloc.add(const ThemeChangedEvent(
                                    theme: AppThemee.blueDark));
                              } else {
                                appThemeBloc.add(const ThemeChangedEvent(
                                    theme: AppThemee.blueLight));
                              }
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state is LoadedThemeState &&
                                    state.themeData ==
                                        appThemeData[AppThemee.blueDark]
                                ? "Dark".tr(context)
                                : "Light".tr(context),
                            style: TextStyle(
                              fontSize: 16,
                              color: state is LoadedThemeState &&
                                      state.themeData ==
                                          appThemeData[AppThemee.blueDark]
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<AppThemeBloc, AppThemeState>(
                    builder: (context, state) {
                      return DayNightSwitcher(
                        isDarkModeEnabled: state is LoadedThemeState &&
                            state.themeData == appThemeData[AppThemee.blueDark],
                        onStateChanged: (isDarkModeEnabled) {
                          final appThemeBloc =
                              BlocProvider.of<AppThemeBloc>(context);
                          if (isDarkModeEnabled) {
                            appThemeBloc.add(const ThemeChangedEvent(
                                theme: AppThemee.blueDark));
                          } else {
                            appThemeBloc.add(const ThemeChangedEvent(
                                theme: AppThemee.blueLight));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
