// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/auth/pages/sign_up_page.dart';
import 'package:real_estaye_app/presentation/tabs/pages/admin_tabs_page.dart';
import 'package:real_estaye_app/presentation/tabs/pages/tabs_screen.dart';

bool isSelected = false;
final _emailcontroller = TextEditingController();
final _passwordcontroller = TextEditingController();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// bool _obscureText = false;

class LoginPagee extends StatefulWidget {
  const LoginPagee({super.key});

  @override
  State<LoginPagee> createState() => _LoginPageeState();
}

class _LoginPageeState extends State<LoginPagee> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
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
            } else if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    selectionColor: Colors.red,
                  ),
                ),
              );
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Hey there,",
                      style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
                    ),
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppTthemeq.iconColor1,
                            ),
                            labelText: "Email"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            filled: true,
                            suffixIcon: const Icon(Icons.remove_red_eye),
                            prefixIcon: Icon(
                              Icons.password,
                              color: AppTthemeq.iconColor1,
                            ),
                            labelText: "Password"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.064,
                      width: MediaQuery.of(context).size.width * 0.94,
                      child: MaterialButton(
                        onPressed: () async {
                          Map authData = {
                            "email": _emailcontroller.text,
                            "password": _passwordcontroller.text,
                          };
                          BlocProvider.of<AuthBloc>(context)
                              .add(LoginUserEvent(authData));
                        },
                        color: AppTheme.secondryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.white,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              width: 130,
                              color: AppTthemeq.lineColor1,
                            ),
                            const Text("  or  "),
                            Container(
                              height: 1,
                              width: 130,
                              color: AppTthemeq.lineColor1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.064,
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: MaterialButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(GoogleSignInSignUpEvent());
                            },
                            color: AppTheme.googleBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: AppTheme.googleIconColor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Countinue With Google",
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.064,
                          width: MediaQuery.of(context).size.width * 0.94,
                          child: MaterialButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NavigationPage(),
                                ),
                              );
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  IconlyBold.profile,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Sign in as anonymous",
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Dont Have an account Register here:",
                              style: TextStyle(fontSize: 16),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SignUpPage()));
                                },
                                child: const Text("Sign Up",
                                    style: TextStyle(fontSize: 16)))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
