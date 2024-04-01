import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/homepage.dart';
//import 'package:studends/screens/contact_details.dart'; // Import your ContactDetails screen
import 'package:studends/servises/controller.dart'; // Import your ContactController

class GridScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  GridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch contacts when the grid screen is initialized
    Future<void> _fetchContacts() async {
      await contactController.fetchContacts();
    }

    // Call _fetchContacts() when the grid screen is initialized
    _fetchContacts();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Students'),
      //   titleSpacing: 00.0,
      //   centerTitle: true,
      //   toolbarHeight: 60.2,
      //   toolbarOpacity: 0.8,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomRight: Radius.circular(25),
      //       bottomLeft: Radius.circular(25),
      //     ),
      //   ),
      //   elevation: 0.00,
      //   backgroundColor: const Color.fromARGB(255, 154, 14, 58),
      // ),
      body: Obx(() => contactController.contacts.isEmpty
          ? const Center(child: Text('No contacts available'))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: contactController.contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contactController.contacts[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to contact details screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ContactDetails(contact: contact),
                    //   ),
                    // );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(contact.profileImagePath)),
                        ),
                        SizedBox(height: 10),
                        Text(
                          contact.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(contact.place),
                      ],
                    ),
                  ),
                );
              },
            )),
   
    );
  }
}
