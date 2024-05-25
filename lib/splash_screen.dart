import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/auth/pages/login_page.dart';
import 'package:real_estaye_app/presentation/tabs/pages/admin_tabs_page.dart';
import 'package:real_estaye_app/presentation/tabs/pages/tabs_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          Timer(const Duration(seconds: 1), () async {
            if (state is LoadedUserState) {
              final user = state.user;

              DocumentSnapshot userDoc =
                  await _firestore.collection('users').doc(user.uid).get();

              if (userDoc.exists) {
                String userType = userDoc['type'];
                if (userType == 'agent') {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AdminNavigationPage()),
                      (route) => false);
                } else if (userType == 'user') {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const NavigationPage()),
                      (route) => false);
                }
              }
            } else if (state is AuthInitial) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const LoginPagee(),
              ));
            }
          });
        },
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlutterLogo(
                size: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
