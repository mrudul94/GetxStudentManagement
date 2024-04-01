import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/editscreen.dart';
import 'package:studends/servises/controller.dart';

class ProfileScreen extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from the home page
    final Map<String, dynamic> arguments = Get.arguments ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.00,
        backgroundColor: const Color.fromARGB(255, 154, 14, 58),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: CircleAvatar(
                  radius: 80,
                  // Load profile image from file path
                  backgroundImage:
                      FileImage(File(arguments['profileImagePath'] ?? '')),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Name  : ${arguments['name']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Place : ${arguments['place']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Age   : ${arguments['age'].toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Number: ${arguments['phoneNumber']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle edit button onPressed event
                      Get.to(EditContactPage(
                          contact: Contact(
                            profileImagePath: arguments['profileImagePath'],
                            name: arguments['name'],
                            age: arguments['age'],
                            place: arguments['place'],
                            phoneNumber: arguments['phoneNumber'],
                          ),
                          index: arguments['index']));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 20), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Are you sure you want to delete?",
                        content: const Text(""),
                        textCancel: "Cancel",
                        textConfirm: "Delete",
                        onConfirm: () {
                          // Call deleteContactByIndex method with the index of the contact
                          controller.deleteContactByIndex(arguments['index']);
                          Get.back(); // Close the dialog
                          Get.back();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Change button color to red
                    ),
                    child: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
