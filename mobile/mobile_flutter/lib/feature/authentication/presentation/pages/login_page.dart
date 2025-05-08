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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
              height: 12,
              width: 12,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
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
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                         SizedBox(height: screenHeight * 0.15),
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
                        
                      ],
                    ),
                  ),
                ),
                // Button at the bottom
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: state is AuthenticatingUser
                          ? null
                          : _handleLogin,
                      isLoading: state is AuthenticatingUser,
                      text: 'Sign in',
                    );
                  },
                ),
                              const SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}