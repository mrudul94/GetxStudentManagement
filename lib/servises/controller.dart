import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studends/models/model.dart';


class ContactController extends GetxController {
  final _contacts = <Contact>[].obs;
    final _searchedContacts = <Contact>[].obs;

  List<Contact> get contacts => _contacts;
  set contacts(List<Contact> value) => _contacts.assignAll(value);
   List<Contact> get searchedContacts => _searchedContacts;

   void searchContacts(String query) {
    if (query.isEmpty) {
      _searchedContacts.clear();
      return;
    }
    _searchedContacts.clear();
    _searchedContacts.addAll(_contacts.where((contact) =>
        contact.name.toLowerCase().contains(query.toLowerCase())));
  }

   void deleteContact(Contact contact) async {
    final contactsBox = Hive.box<Contact>('contacts');
    contacts.remove(contact);
    await contactsBox.delete(contact.key); // Assuming 'key' is a unique identifier for each contact
  }

  addContact(Contact contact) async {
    final contactsBox = Hive.box<Contact>('contacts');
    contacts.add(contact);
    await contactsBox.add(contact);
  }

  
  Future<void> fetchContacts() async {
    final contactsBox = Hive.box<Contact>('contacts');
    contacts = contactsBox.values.toList().obs;
  }
}
