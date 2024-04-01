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
   backgroundColor: const Color.fromARGB(255, 154, 14, 58),
        
          title: const Center(child: Text('Students')),
          actions: [
            IconButton(onPressed: (){
              contactController.signOut();
              
            }, icon: const Icon(Icons.exit_to_app))
          ],
          bottom: const TabBar(
            
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Grid'),
            ],
           indicatorColor: Color.fromARGB(255, 238, 235, 235),
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
