import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_estaye_app/core/widgets/snack_bar.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/auth/pages/sign_in_page.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/account_card.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/age_height_wieght.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/other_card.dart';
import 'package:real_estaye_app/presentation/profile_page/widgets/pop_up_notification.dart';

bool isSelected = true;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              MaterialPageRoute(builder: (_) => const LoginPage()),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: SvgPicture.asset("assets/Workout-Pic.svg"),
                    title: const Text(
                      "Anas Ahmed",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Lose Widhgt"),
                    trailing: MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: const Text("Edit"),
                    ),
                  ),
                ),
                const AgeHeightWieghtCard(),
                const AccountProfileCard(),
                const PopUpNotificationCard(),
                const OtherProfileCard(),
                MaterialButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                  },
                  color: Colors.red,
                  child: const Text("Logout"),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
