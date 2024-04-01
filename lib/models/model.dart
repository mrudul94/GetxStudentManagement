import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  @HiveField(2)
  String place;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String profileImagePath;

  Contact({
    required this.name,
    required this.age,
    required this.place,
    required this.phoneNumber,
    required this.profileImagePath,
  });
}
