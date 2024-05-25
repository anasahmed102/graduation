// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estaye_app/core/theme/app_theme.dart';
import 'package:real_estaye_app/core/widgets/loading_widget.dart';
import 'package:real_estaye_app/features/auth/logic/bloc/auth_bloc.dart';

class LoginButtonPage extends StatelessWidget {
  const LoginButtonPage({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.064,
      width: MediaQuery.of(context).size.width * 0.94,
      child: MaterialButton(
        onPressed: () async {
          Map authData = {
            "email": email,
            "password": password,
          };
          const LoadingWidget();
          BlocProvider.of<AuthBloc>(context).add(LoginUserEvent(authData));
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
    );
  }
}
