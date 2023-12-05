import 'package:flutter/material.dart';
import 'package:medical_appointment_app/utils/config.dart';
import 'package:medical_appointment_app/views/initial_view.dart';
import 'package:medical_appointment_app/views/home_view.dart';
import 'package:medical_appointment_app/views/login_view.dart';
import 'package:medical_appointment_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialView(),
        '/home': (context) => const HomeView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
      },
    );
  }
}
