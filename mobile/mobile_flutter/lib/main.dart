import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uniconnect_app/core/router/app_router.dart';
import 'package:uniconnect_app/core/utils/l10n/arb/app_localizations.dart';
import 'package:uniconnect_app/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:uniconnect_app/feature/event/presentation/bloc/event_bloc.dart';
import 'package:uniconnect_app/feature/university/presentation/bloc/uni_bloc.dart';
import 'core/providers/event_provider.dart';
import 'feature/shared/splash_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await init();
  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

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
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            debugShowCheckedModeBanner: false,
            navigatorObservers: [routeObserver],
            title: 'UniConnect',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              scaffoldBackgroundColor: const Color.fromARGB(255, 2, 27, 52),
            ),
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.splash,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}