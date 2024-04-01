import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studends/main.dart';
import 'package:studends/screens/homepage.dart';
import 'package:studends/screens/loginscreen.dart';

class Screensplash extends StatelessWidget {
  Screensplash({Key? key}) : super(key: key) {
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 250,
        ),
      ),
    );
  }

  void checkUserLoggedIn() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    final bool? userLoggedIn = sharedPrefs.getBool(save_key_name);
    if (userLoggedIn == null || !userLoggedIn) {
      goToLogin();
    } else {
      goToHome();
    }
  }

  void goToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => ScreenLogin());
    });
  }

  void goToHome() {
    Get.off(() => HomePage());
  }
}
