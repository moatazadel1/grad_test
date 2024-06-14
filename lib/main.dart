import 'package:flutter_config/flutter_config.dart';
import 'package:new_app/home/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/pages/Home/home_pages.dart';
import 'package:new_app/pages/List/list_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/SignUp/sign_up_screen.dart';
import 'auth/login/login.dart';
import 'firebase_options.dart';
import 'onboardingscreen/onboardingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); // Run your app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              titleTextStyle: TextStyle(fontSize: 16, color: Colors.black)),
          scaffoldBackgroundColor: Colors.transparent,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff0076CA),
            primary: const Color(0xff0076CA),
            secondary: Colors.black,
            onSecondary: Colors.white,
          ),
          useMaterial3: false,
          primaryColor: const Color(0xff0076CA)),
      routes: {
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        Login.routeName: (_) => const Login(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        HomePage.routeName: (_) => const HomePage(),
        ListPage.routeName: (_) => const ListPage(),
      },
      home: FutureBuilder(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data == true
                ? const HomeScreen()
                : const OnboardingScreen();
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
