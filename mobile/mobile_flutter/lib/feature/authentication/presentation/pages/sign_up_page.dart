import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
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
  final fullNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final universityController = TextEditingController();
  final locationController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  void _handleSignUp() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final birthday = birthdayController.text.trim();
    // final university = universityController.text.trim();
    // final repeatPassword = repeatPasswordController.text.trim();

    try {
      final parsedBirthday = DateFormat('yyyy-MM-dd').parse(birthday);

      context.read<AuthenticationBloc>().add(SignUpUserEvent(
            fullName: fullName,
            email: email,
            password: password,
            birthday: parsedBirthday,
            location: locationController.text.trim(),
            uniId: 1,
          ));
    } catch (e) {
      Logger().e('Invalid date format: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid date format. Please use yyyy-MM-dd.')),
      );
    }
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
            if (state is SignUpUserSuccess) {
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
            } else if (state is SignUpUserError) {
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
                          loc.createNewAccount,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),

                        // Full Name
                        CustomTextField(
                          controller: fullNameController,
                          label: loc.fullNameLabel,
                          hintText: loc.fullNameHint,
                        ),
                        const SizedBox(height: 15),

                        // Email Address
                        CustomTextField(
                          controller: emailController,
                          label: loc.emailLabel,
                          hintText: loc.emailHint,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15),

                        // Birthday
                        CustomTextField(
                          controller: birthdayController,
                          label: loc.birthdayLabel,
                          hintText: loc.birthdayHint,
                          isDatePicker: true,
                        ),
                        const SizedBox(height: 15),

                        // University
                        CustomTextField(
                          controller: universityController,
                          label: loc.universityLabel,
                          hintText: loc.universityHint,
                        ),
                        const SizedBox(height: 15),
                        // Location
                        CustomTextField(
                          controller: locationController,
                          label: 'Location',
                          hintText: 'Location',
                          isPassword: false,
                        ),
                        const SizedBox(height: 15),

                        // Password
                        CustomTextField(
                          controller: passwordController,
                          label: loc.passwordLabel,
                          hintText: loc.passwordHint,
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),

                        // Repeat Password
                        CustomTextField(
                          controller: repeatPasswordController,
                          label: loc.repeatPasswordLabel,
                          hintText: loc.repeatPasswordHint,
                          isPassword: true,
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
                // Button at the bottom
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: CustomButton(
                        onPressed:
                            state is AuthenticatingUser ? null : _handleSignUp,
                        isLoading: state is AuthenticatingUser,
                        text: loc.signInButton,
                      ),
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
