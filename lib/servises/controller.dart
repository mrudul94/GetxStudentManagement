import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studends/models/model.dart';

class ContactController extends GetxController {
  final _contacts = <Contact>[].obs;

  List<Contact> get contacts => _contacts;
  set contacts(List<Contact> value) => _contacts.assignAll(value);

  addContact(Contact contact) async {
    final contactsBox = Hive.box<Contact>('contacts');
    contacts.add(contact);
    await contactsBox.add(contact);
  }

  Future<void> fetchContacts() async {
    final contactsBox = Hive.box<Contact>('contacts');
    contacts = contactsBox.values.toList().obs;
  }
   void deleteContactByIndex(int index) async {
    final contactsBox = Hive.box<Contact>('contacts');
    await contactsBox.deleteAt(index);
    _contacts.removeAt(index);
  }


   void editContact(int index, Contact updatedContact) async {
    final contactsBox = Hive.box<Contact>('contacts');
    await contactsBox.putAt(index, updatedContact);
    _contacts[index] = updatedContact;
  }
}

