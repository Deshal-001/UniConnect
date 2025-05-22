import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:uniconnect_app/core/widget/custom_text_field.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uniconnect_app/feature/university/presentation/bloc/uni_bloc.dart';

import '../../../../core/helper/validation_method.dart';
import '../../../../core/widget/custom_button.dart';
import '../../../university/domain/entity/university.dart';

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

  late List<University> universities = [];
  University? selectedUniversity;

  void _handleSignUp() {
    final controllers = [
      fullNameController,
      emailController,
      passwordController,
      birthdayController,
      locationController,
      repeatPasswordController,
    ];

      if (controllers.any((controller) => controller.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final birthday = birthdayController.text.trim();

    try {
      // Parse the date from 'dd/MM/yyyy' format
      final parsedBirthday = DateFormat('dd/MM/yyyy').parse(birthday);

      if (selectedUniversity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a university')),
        );
        return;
      }
      if (!ValidationMethod().isPasswordsMatch(
        password.trim(),
        repeatPasswordController.text.trim(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      if (!ValidationMethod().isValidEmail(email.trim())) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')),
        );
        return;
      }

      // Trigger the sign-up event
      context.read<AuthenticationBloc>().add(SignUpUserEvent(
            fullName: fullName,
            email: email,
            password: password,
            birthday: parsedBirthday, // Use the parsed DateTime object
            location: locationController.text.trim(),
            uniId: selectedUniversity!.id ?? 0,
          ));
    } catch (e) {
      Logger().e('Invalid date format: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid date format. Please use dd/MM/yyyy.')),
      );
    }
  }

  @override
  void initState() {
    Logger().e('SignUpPage initialized');
    context.read<UniversityBloc>().add(const GetAllUniversitiesEvent());
    super.initState();
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
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
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
                    content:
                        Text('Error ${state.statusCode}: ${state.message}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(loc.okButton),
                      )
                    ],
                  ),
                );
              }
            }),
            BlocListener<UniversityBloc, UnoversityState>(
                listener: (context, state) {
              if (state is GetAllUniversitiesError) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(loc.loginFailedTitle),
                    content:
                        Text('Error ${state.statusCode}: ${state.message}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(loc.okButton),
                      )
                    ],
                  ),
                );
              } else if (state is GetAllUniversitiesSuccess) {
                universities.clear();
                setState(() {
                  universities.addAll(state.universities);
                });
                Logger().e('Universities: ${universities.length}');
              } else if (state is GetAllUniversitiesLoading) {
                Logger().e('Loading universities...');
              } else {
                Logger().e('State: $state');
              }
            }),
          ],
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

                        // University Dropdown
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loc.universityLabel,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: DropdownButtonFormField<University>(
                                value: selectedUniversity,
                                items: universities
                                    .map((university) => DropdownMenuItem(
                                          value: university,
                                          child: Text(university.name ?? ''),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedUniversity = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  // labelText: loc.universityLabel,
                                  hintText: loc.universityHint,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
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
