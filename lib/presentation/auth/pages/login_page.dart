import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/loading_widget.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/tabs/pages/tabs_screen.dart';

bool isSelected = false;
late TextEditingController emailController;
late TextEditingController passwordController;
bool _obscureText = false;

class LoginPagee extends StatefulWidget {
  const LoginPagee({super.key});

  @override
  State<LoginPagee> createState() => _LoginPageeState();
}

class _LoginPageeState extends State<LoginPagee> {
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoadedUserState) {
            const LoadingWidget();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const NavigationPage()),
              (route) => false,
            );
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
                      controller: emailController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppTtheme.iconColor1,
                          ),
                          labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          filled: true,
                          suffixIcon: const Icon(Icons.remove_red_eye),
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppTtheme.iconColor1,
                          ),
                          labelText: "Password"),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: false,
                  //       onChanged: (value) {},
                  //     ),
                  //     const Text(
                  //       "By continuing you accept our Privacy Policy and\n Term of Use",
                  //       textAlign: TextAlign.start,
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.064,
                    width: MediaQuery.of(context).size.width * 0.94,
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Map authData = {
                            "email": emailController.text,
                            "password": passwordController.text,
                          };
                          const LoadingWidget();
                          BlocProvider.of<AuthBloc>(context)
                              .add(LoginUserEvent(authData));

                          await Future.delayed(const Duration(seconds: 2));

                          User? user = FirebaseAuth.instance.currentUser;

                          // Check if the user is not null
                          if (user != null) {
                            try {
                              // Save user information to Firestore
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .set({
                                'uid': user.uid,
                                'displayName':
                                    user.email ?? 'Default Display Name',
                                // You can add more fields as needed
                              });

                              debugPrint(
                                  'User information successfully saved to Firestore.');
                            } catch (e) {
                              debugPrint(
                                  'Error saving user information to Firestore: $e');
                            }

                            // Navigate to the next screen or perform any other action after successful login
                          }
                        }
                      },
                      color: AppTheme.secondryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
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
                            color: AppTtheme.lineColor1,
                          ),
                          const Text("  or  "),
                          Container(
                            height: 1,
                            width: 130,
                            color: AppTtheme.lineColor1,
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
                            // await FirebaseAuth.instance.signInAnonymously();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const NavigationPage()));
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
                      const Text("Forgot password?",
                          style: TextStyle(
                            fontSize: 18,
                          )),
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
                              onPressed: () {},
                              child: const Text("Sign Up",
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: ShapeDecoration(
                      //           shape: RoundedRectangleBorder(
                      //               side: const BorderSide(color: Colors.black),
                      //               borderRadius: BorderRadius.circular(16))),
                      //       child: Icon(
                      //         FontAwesomeIcons.facebook,
                      //         color: AppTtheme.facebookIconColor,
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 40,
                      //     ),
                      //     Container(
                      //         height: 50,
                      //         width: 50,
                      //         decoration: ShapeDecoration(
                      //             shape: RoundedRectangleBorder(
                      //                 side: const BorderSide(color: Colors.black),
                      //                 borderRadius: BorderRadius.circular(16))),
                      //         child: const Icon(FontAwesomeIcons.google)),
                      //   ],
                      // ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
