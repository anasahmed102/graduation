import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/loading_widget.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';
import 'package:real_estaye_app/presentation/auth/pages/sign_up_page.dart';
import 'package:real_estaye_app/presentation/tabs/pages/tabs_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocListener<AuthBloc, AuthState>(
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
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const FlutterLogo(
                    size: 120,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Login To Your Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: emailController,
                      validator: (val) =>
                          val!.isEmpty ? "Email Is empty" : null,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (val) =>
                          val!.isEmpty ? "Password Is empty" : null,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      obscureText: !_obscureText,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(0, 60),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.facebookIconColor,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.facebook),
                          color: Colors.white, // Icon color
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.googleIconColor,
                        ),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(GoogleSignInSignUpEvent());
                          },
                          icon: const Icon(FontAwesomeIcons.google),
                          color: Colors.white, // Icon color
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whatsappIconColor,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.whatsapp),
                          color: Colors.white, // Icon color
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signInAnonymously();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const NavigationPage()));
                        } catch (e) {
                          print('Error signing in anonymously: $e');
                        }
                      },
                      child: const Text("Login Anonymously")),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpPage()));
                    },
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: 200,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
