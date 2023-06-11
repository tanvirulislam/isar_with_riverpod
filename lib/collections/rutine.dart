import 'package:isar/isar.dart';
part 'rutine.g.dart';

@collection
class Rutine {
  Id id = Isar.autoIncrement;
  String? name;
  String? email;
  String? address;
}
