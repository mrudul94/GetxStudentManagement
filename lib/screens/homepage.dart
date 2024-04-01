import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studends/screens/addscreen.dart';

import 'package:studends/screens/gridscreen.dart';
import 'package:studends/screens/listscreen.dart';

import 'package:studends/servises/controller.dart';

class HomePage extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  HomePage({Key? key}) : super(key: key) {
    // Fetch contacts when the home screen is initialized
    contactController.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
          bottom: const TabBar(
            
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Grid'),
            ],
           indicatorColor: Colors.black,
          ),
        ),
        body: TabBarView(
          
          children: [
            ContactList(),
            GridScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddContactPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
