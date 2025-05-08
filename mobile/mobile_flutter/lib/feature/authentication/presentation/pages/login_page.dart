import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uniconnect_app/core/widget/custom_text_field.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';

import '../../../../core/widget/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    context
        .read<AuthenticationBloc>()
        .add(LoginUserEvent(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: SvgPicture.asset(
          'assets/icons/arrow-left.svg',
          height: 12,
          width: 12,
          fit: BoxFit.scaleDown,
        )),
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is UserAuthenticated) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Login Successful'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
            } else if (state is UserAuthenticatingError) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Login Failed'),
                  content: Text('Error ${state.statusCode}: ${state.message}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back !',
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      label: 'Email address',
                      hintText: 'name@example.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 35),
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      hintText: 'Enter your password',
                      isPassword: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed:
                          state is AuthenticatingUser ? null : _handleLogin,
                      isLoading: state is AuthenticatingUser,
                      text: 'Sign in',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
