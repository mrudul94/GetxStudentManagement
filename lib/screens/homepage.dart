import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:studends/screens/addscreen.dart';
import 'package:studends/servises/controller.dart';

class HomePage extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                contactController.searchContacts(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: contactController.searchedContacts.isEmpty
                    ? contactController.contacts.length
                    : contactController.searchedContacts.length,
                itemBuilder: (context, index) {
                  Contact contact = contactController.searchedContacts.isEmpty
                      ? contactController.contacts[index]
                      : contactController.searchedContacts[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              FileImage(File(contact.profileImagePath)),
                        ),
                        title: Text(contact.name),
                        subtitle: Text(contact.age.toString()),
                        trailing:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                             IconButton(onPressed: (){
                               showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure you want to delete?"),
        //  content: Text("This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                    Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                  contactController.deleteContact(contact);
                    Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
                             
                             }, icon: Icon(Icons.delete,color: Colors.red,))

                          ],
                        ) ,
                        onTap: () {
                          // Navigate to detail page if needed
                        },
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddContactPage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
