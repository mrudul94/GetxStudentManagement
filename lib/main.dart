import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:studends/models/model.dart';

import 'package:studends/screens/screensplash.dart';



// ignore: constant_identifier_names
const save_key_name = 'userloggedin';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Contact>('contacts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Screensplash(),
      
     
    );
  }
}
