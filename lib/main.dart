// ignore_for_file: await_only_futures

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:real_estaye_app/core/helper/bloc_observer.dart';
import 'package:real_estaye_app/core/lang/bloc/localaize_state.dart';
import 'package:real_estaye_app/core/lang/bloc/localize_cubit.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/core/theme/bloc/apptheme_bloc.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/addUpdateDeleteProperty/bloc/add_update_delete_propery_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/bloc/posts_bloc.dart';
import 'package:real_estaye_app/features/posts/logic/favorites/favorites_bloc.dart';
import 'package:real_estaye_app/firebase_options.dart';
import 'package:real_estaye_app/injection.dart';
import 'package:real_estaye_app/splash_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initBinding();

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(),
          ),
          BlocProvider(
            create: (context) => FavoritesBloc(),
          ),
          BlocProvider(
            create: (context) => AddUpdateDeleteProperyBloc(),
          ),
          BlocProvider(
            create: (context) => getIt<AuthBloc>()..add(GetCurrentUserEvent()),
          ),
          BlocProvider(
            create: (context) => AppThemeBloc()..add(GetCurrentThemeEvent()),
          ),
          BlocProvider(
            create: (context) => LocalizeCubit()..getSavedLanguage(),
          ),
        ],
        child: BlocBuilder<LocalizeCubit, ChangeLocaleState>(
          builder: (context, state) {
            return BlocConsumer<AppThemeBloc, AppThemeState>(
              listener: (context, themeState) {
              },
              builder: (context, themeState) {
                if (themeState is LoadedThemeState) {
                  return MaterialApp(
                    locale: state.locale,
                    supportedLocales: const [Locale('en'), Locale('ar')],
                    localizationsDelegates: const [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeResolutionCallback: (deviceLocale, supportedLocales) {
                      for (var locale in supportedLocales) {
                        if (deviceLocale != null &&
                            deviceLocale.languageCode == locale.languageCode) {
                          return deviceLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    theme: themeState.themeData,
                    debugShowCheckedModeBanner: false,
                    title: 'Theme App',
                    home: const SplashScreen(),
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                }
              },
            );
          },
        ));
  }
}
