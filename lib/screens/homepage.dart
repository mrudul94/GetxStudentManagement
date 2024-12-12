import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studends/screens/addscreen.dart';

import 'package:studends/screens/gridscreen.dart';
import 'package:studends/screens/listscreen.dart';

import 'package:studends/servises/controller.dart';

class HomePage extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  HomePage({Key? key}) : super(key: key) {
    contactController.fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
              child: Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Students',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )),
          actions: [
            IconButton(
                onPressed: () {
                  contactController.signOut();
                },
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ))
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
            Get.to(()=>AddContactPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
