import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uniconnect_app/core/widget/custom_text_field.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/widget/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
    final loc = AppLocalizations.of(context)!;

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
                  title: Text(loc.loginSuccessTitle),
                  content: Text(loc.loginSuccessMessage),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(loc.okButton),
                    )
                  ],
                ),
              );
            } else if (state is UserAuthenticatingError) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(loc.loginFailedTitle),
                  content: Text('Error ${state.statusCode}: ${state.message}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(loc.okButton),
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
                        Text(
                          loc.welcomeBack,
                          style: const TextStyle(
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
                              label: loc.emailLabel,
                              hintText: loc.emailHint,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 35),
                            CustomTextField(
                              controller: passwordController,
                              label: loc.passwordLabel,
                              hintText: loc.passwordHint,
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
                      onPressed:
                          state is AuthenticatingUser ? null : _handleLogin,
                      isLoading: state is AuthenticatingUser,
                      text: loc.signInButton,
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
