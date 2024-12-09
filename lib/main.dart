import 'package:course_correct/screens/email_signin.dart';
import 'package:course_correct/screens/interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'bottomnavigators/reminder.dart';
import 'components/profilescreen.dart';
import 'pages/settingspages/profile.dart';
import 'pageview.dart';
import 'profileprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await NotificationService.initializeNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileProvider()..loadProfileData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Correct',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      // Define the initial route and other named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/pageview': (context) => const Pageview(),
        '/profile': (context) => const ProfileScreen(),
        '/profile-settings': (context) => const ProfileSettings(),
        '/signin': (context) => EmailSignin(
              obscureText: true,
              hintext: '',
              controller: null,
            ),
        '/interface': (context) => const Interface()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (mounted) {
        if (user != null) {
          // user is signed in
          Navigator.pushReplacementNamed(context, '/interface');
        } else {
          // user is not signed in
          Navigator.pushReplacementNamed(context, '/signin');
        }
        Navigator.pushReplacementNamed(context, '/pageview');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
