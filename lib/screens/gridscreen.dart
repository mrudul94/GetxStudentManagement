import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/editscreen.dart';
import 'package:studends/screens/profilepage.dart';
import 'package:studends/servises/controller.dart';

class GridScreen extends StatelessWidget {
  final ContactController contactController = Get.find();

  GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => contactController.contacts.isEmpty
        ? const Center(child: Text('No contacts available'))
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: contactController.contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contactController.contacts[index];
              return GestureDetector(
                onTap: () {
                  Get.to(ProfileScreen(), arguments: {
                    'profileImagePath': contact.profileImagePath,
                    'name': contact.name,
                    'place': contact.place,
                    'age': contact.age,
                    'phoneNumber': contact.phoneNumber,
                    'index': index,
                  });
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            FileImage(File(contact.profileImagePath)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        contact.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(contact.place),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result = await Get.to(EditContactPage(
                                  contact: contact, index: index));
                              if (result != null) {
                             
                                contactController.contacts[index] =
                                    contactController.contacts[result];
                              }
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.black,
                          ),
                          IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Are you sure you want to delete?",
                                content: const Text(""),
                                textCancel: "Cancel",
                                textConfirm: "Delete",
                                onConfirm: () {
                                  contactController.deleteContactByIndex(index);
                                  Get.back();
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 154, 14, 58),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ));
  }
}
