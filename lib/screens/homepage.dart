import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/addscreen.dart';
import 'package:studends/screens/editscreen.dart';
import 'package:studends/screens/gridscreen.dart';
import 'package:studends/screens/profilepage.dart';
import 'package:studends/servises/controller.dart';

class HomePage extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch contacts when the home screen is initialized
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _fetchContacts() async {
      await contactController.fetchContacts();
    }

    // Call _fetchContacts() when the home screen is initialized
    _fetchContacts();

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Students'),
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Grid'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // First tab view - List
            Obx(() => contactController.contacts.isEmpty
                ? const Center(child: Text('No contacts available'))
                : ListView.builder(
                    itemCount: contactController.contacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = contactController.contacts[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  File(contact.profileImagePath)),
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.place),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final result = await Get.to(
                                        EditContactPage(
                                            contact: contact, index: index));
                                    if (result != null) {
                                      contactController.contacts[result] =
                                          contactController.contacts[result];
                                    }
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.black,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      // Use Get.defaultDialog for showing the dialog
                                      title:
                                          "Are you sure you want to delete?",
                                      content: const Text(""),
                                      textCancel: "Cancel",
                                      textConfirm: "Delete",
                                      onConfirm: () {
                                        contactController
                                            .deleteContactByIndex(index);
                                        Get.back();
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: const Color.fromARGB(
                                        255, 154, 14, 58),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              Get.to(ProfileScreen(), arguments: {
                                'profileImagePath':
                                    contact.profileImagePath,
                                'name': contact.name,
                                'place': contact.place,
                                'age': contact.age,
                                'phoneNumber': contact.phoneNumber,
                                'index': index,
                              });
                            },
                          ),
                          const Divider()
                        ],
                      );
                    },
                  )),
            // Second tab view - Grid
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
