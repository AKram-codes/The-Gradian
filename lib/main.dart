import 'package:flutter/material.dart';
import 'package:the_gradian/screens/login_screen.dart';
import 'package:the_gradian/screens/signup_screen.dart';
import 'package:the_gradian/screens/parent_dashboard.dart';
import 'package:the_gradian/screens/gradian_dashboard.dart';
import 'package:the_gradian/screens/booking_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Gradian',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.yellow,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/parent_dashboard': (context) => ParentDashboard(),
        '/gradian_dashboard': (context) => GradianDashboard(),
        '/booking': (context) => BookingScreen(),
      },
    );
  }
}