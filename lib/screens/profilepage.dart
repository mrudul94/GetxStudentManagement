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
              const SizedBox(
                height: 60,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        // Retrieve the contact object from the controller's list using the index
                        Contact contact =
                            controller.contacts[arguments['index']];
                        // Navigate to the EditContactPage with the retrieved contact and index
                        Get.to(EditContactPage(
                            contact: contact, index: arguments['index']));
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit")),

                  // IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Are you sure you want to delete?",
                          content: const Text(""),
                          textCancel: "Cancel",
                          textConfirm: "Delete",
                          onConfirm: () {
                            controller.deleteContactByIndex(arguments['index']);
                            Get.back();
                            Get.back();
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
