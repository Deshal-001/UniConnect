import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uniconnect_app/core/router/app_router.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uniconnect_app/feature/shared/splash_screen.dart';

import 'core/injection_container.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthenticationBloc>()),
      ],
      child: MaterialApp(
        title: 'UniConnect',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash
      ),
    );
  }
}

