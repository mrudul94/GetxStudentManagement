import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studends/models/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studends/servises/controller.dart';

class EditContactPage extends StatelessWidget {
  final ContactController contactController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  late final Rx<File?> _image;
  final int index;

  EditContactPage({super.key, required Contact contact, required this.index})
      : _image = Rx<File?>(File(contact.profileImagePath)) {
    nameController.text = contact.name;
    ageController.text = contact.age.toString();
    placeController.text = contact.place;
    phoneNumberController.text = contact.phoneNumber;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
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
        backgroundColor:  Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () async {
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
                      child: _image.value != null && _image.value!.existsSync()
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
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: placeController,
                decoration: const InputDecoration(labelText: 'Place'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_image.value != null) {
                    Contact updatedContact = Contact(
                      name: nameController.text,
                      age: int.tryParse(ageController.text) ?? 0,
                      place: placeController.text,
                      phoneNumber: phoneNumberController.text,
                      profileImagePath: _image.value!.path,
                    );
             
                    contactController.editContact(index, updatedContact);
                
                    Get.back(result: index);
                  } else {
                    
                    Get.snackbar(
                      'Error',
                      'Please select an image',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }



  
  Future<void> _getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }

  Future<void> _getImageCamera() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image.value = File(pickedFile.path);
    }
  }
}
