import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/addscreen.dart';
import 'package:studends/screens/homepage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Contact>('contacts');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      
      //initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => HomePage()),
      //   GetPage(name: '/addContact', page: () => AddContactPage()),
      // ],
    );
  }
}
