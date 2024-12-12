import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studends/models/model.dart';
import 'package:studends/servises/controller.dart';

class AddContactPage extends StatelessWidget {
  final ContactController contactController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final Rx<File?> _image = Rx<File?>(File(''));

  AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Student'),
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
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.black,
                    context: context,
                    builder: (BuildContext builderContext) {
                      return SizedBox(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await _getImage();
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Gallery",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await _getImageCamera();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Camera",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Obx(
                  () => CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    child: ClipOval(
                      child: _image.value != null &&
                              _image.value!.existsSync()
                          ? Image.file(
                              _image.value!,
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            )
                          : Image.network(
                              "https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=",
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter age';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: placeController,
                decoration: const InputDecoration(labelText: 'Place'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a place';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_image.value != null) {
                      Contact newContact = Contact(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        place: placeController.text,
                        phoneNumber: phoneNumberController.text,
                        profileImagePath: _image.value!.path,
                      );
                      contactController.addContact(newContact);
                      Get.back();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please select an image',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  Future<void> _getImageCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }
}
