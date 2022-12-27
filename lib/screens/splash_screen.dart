import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todoolist/screens/home_screen.dart';
// import 'package:todoolist/screens/home_screen.dart';
import 'package:todoolist/screens/welcome_screen.dart';
import 'package:todoolist/widgets/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userName = prefs.getString("userName");
  // }

  @override
  void initState() {
    checkUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('lib/assests/calendario-branco.json'),
        backgroundColor: Colors.green,
        duration: 3200,
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 250,
        nextScreen: widget
        // const MyBottomNavigationBar(),
        );
  }

  checkUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // ignore: no_leading_underscores_for_local_identifiers
    final _userName = pref.getString('userName');
    // ignore: unrelated_type_equality_checks
    if (_userName == null || _userName == false) {
      await Future.delayed(const Duration(seconds: 2));
      // ignore: use_build_context_synchronously
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx1) {
        return const WelcomeScreen();
      }));
    } else {
      await Future.delayed(const Duration(seconds: 2));
      // ignore: use_build_context_synchronously
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (cotx1) {
        return const MyBottomNavigationBar();
      }));
    }
  }
}
