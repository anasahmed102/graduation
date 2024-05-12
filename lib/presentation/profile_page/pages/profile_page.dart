// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:real_estaye_app/core/theme/app_theme.dart';
// import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
// import 'package:real_estaye_app/presentation/auth/pages/login_page.dart';
// import 'package:real_estaye_app/presentation/profile_page/widgets/account_card.dart';
// import 'package:real_estaye_app/presentation/profile_page/widgets/pop_up_notification.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _checkCurrentUser();
//   }

//   void _checkCurrentUser() {
//     _user = _auth.currentUser;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               const Center(
//                 child: Text(
//                   "Profile",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               if (_user == null)
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Center(
//                       child: Text(
//                         "Please make an account to see the profile ",
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const LoginPagee()),
//                         );
//                       },
//                       child: const Text("Create account"),
//                     ),
//                   ],
//                 ),
//               if (_user != null)
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ListTile(
//                     leading: SvgPicture.asset("assets/images/Workout-Pic.svg"),
//                     title: const Text(
//                       "Anas Ahmed",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     trailing: MaterialButton(
//                       onPressed: () {},
//                       color: AppTheme.secondryColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16)),
//                       child: const Text("Edit"),
//                     ),
//                   ),
//                 ),
//               if (_user != null) const AccountProfileCard(),
//               if (_user != null) const PopUpNotificationCard(),
//               if (_user != null)
//                 MaterialButton(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   onPressed: () async {
//                     await _auth.signOut();
//                     BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
//                   },
//                   color: AppTheme.secondryColor,
//                   child: const Padding(
//                     padding: EdgeInsets.all(14.0),
//                     child: Text("Logout"),
//                   ),
//                 ),
//               const SizedBox(height: 60),
//               const Text(
//                 "version 1.0.0",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estaye_app/core/lang/bloc/localaize_state.dart';
import 'package:real_estaye_app/core/lang/bloc/localize_cubit.dart';
import 'package:real_estaye_app/core/lang/localization.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/auth/pages/login_page.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/account_card.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/pop_up_notification.dart';

bool isSelected = true;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is MessageState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPagee()),
              (route) => false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (_user == null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Please make an account to see the profile "
                              .tr(context),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPagee()),
                          );
                        },
                        child: Text("Create account".tr(context)),
                      ),
                    ],
                  ),
                if (_user != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      leading:
                          SvgPicture.asset("assets/images/Workout-Pic.svg"),
                      title: Text(
                        _user!.email.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: MaterialButton(
                        onPressed: () {},
                        color: AppTheme.secondryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Text("Edit".tr(context)),
                      ),
                    ),
                  ),
                // const LanguageCard(),
                if (_user != null) const AccountProfileCard(),
                if (_user != null)
                  const SizedBox(
                    height: 20,
                  ),
                if (_user != null) const PopUpNotificationCard(),
                if (_user != null)
                  BlocBuilder<LocalizeCubit, ChangeLocaleState>(
                    builder: (context, state) {
                      String selectedLanguage = state.locale.languageCode;

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "App Language".tr(context),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildLanguageOption(
                                    languageCode: 'en',
                                    flagPath: 'assets/images/us.png',
                                    label: 'English'.tr(context),
                                    selectedLanguage: selectedLanguage,
                                    changeLanguage: (languageCode) {
                                      BlocProvider.of<LocalizeCubit>(context)
                                          .changeLanguage(languageCode);
                                    },
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  buildLanguageOption(
                                    languageCode: 'ar',
                                    flagPath: 'assets/images/iq.png',
                                    label: 'Arabic'.tr(context),
                                    selectedLanguage: selectedLanguage,
                                    changeLanguage: (languageCode) {
                                      BlocProvider.of<LocalizeCubit>(context)
                                          .changeLanguage(languageCode);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                // const OtherProfileCard(),
                if (_user != null)
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                    },
                    color: AppTheme.secondryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text("Logout".tr(context)),
                    ),
                  ),
                if (_user != null)
                  const SizedBox(
                    height: 60,
                  ),
                if (_user != null)
                  const Text(
                    "version 1.0.0",
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLanguageOption({
    required String languageCode,
    required String flagPath,
    required String label,
    required String selectedLanguage,
    required Function(String)
        changeLanguage, // Callback function to change language
  }) {
    bool isSelected = selectedLanguage == languageCode;
    Color borderColor =
        isSelected ? AppTheme.secondryColor : Colors.transparent;

    return GestureDetector(
      onTap: () {
        changeLanguage(languageCode); // Call the function to change language
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(flagPath),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
