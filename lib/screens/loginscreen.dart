import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studends/main.dart';
import 'package:studends/screens/homepage.dart';

class ScreenLogin extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _isDataMatched = true.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 182, 179, 179),
      appBar: AppBar(
        title: const Center(child: Text('Login Page')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 209, 207, 229),
              ),
              height: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a username ';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() => Visibility(
                          visible: !_isDataMatched.value,
                          child: const Text(
                            'Username and password do not match',
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkLogin();
                        }
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username == 'febin' && password == '0000' ||
        username == 'noufan' && password == '1234') {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool(save_key_name, true);
      Get.off(() => HomePage());
      print('Username and password match');
    } else {
      _isDataMatched.value = false;
    }
  }
}
