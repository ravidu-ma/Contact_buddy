import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:contact_buddy_app/screens/home_screen.dart';
import 'package:contact_buddy_app/screens/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

int? isViewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onboard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Buddy',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: AnimatedSplashScreen.withScreenFunction(
          backgroundColor: Color.fromARGB(255, 49, 49, 49),
          splash: 'assets/images/logo.png',
          splashIconSize: 100,
          splashTransition: SplashTransition.sizeTransition,
          screenFunction: () async {
            return isViewed != 0 ? OnBoardScreen() : HomeScreen();
          }),
    );
  }
}
