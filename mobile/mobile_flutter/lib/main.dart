import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect_app/core/router/app_router.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uniconnect_app/feature/event/presentation/bloc/event_bloc.dart';
import 'package:uniconnect_app/feature/university/presentation/bloc/uni_bloc.dart';
import 'core/providers/event_provider.dart';
import 'feature/shared/splash_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthenticationBloc>()),
          BlocProvider(create: (context) => sl<UniversityBloc>()),
          BlocProvider(create: (context) => sl<EventBloc>()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: _locale,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [routeObserver],
          title: 'UniConnect',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splash,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
