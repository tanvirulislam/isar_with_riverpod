import 'package:isar/isar.dart';
import 'package:isar_with_riverpod/collections/rutine.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

class IsarService {
  static Future<void> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [RutineSchema],
      directory: dir.path,
    );
  }

  static Future<void> addRoutine({
    required nameController,
    required emailController,
    required ageController,
  }) async {
    final addRoutine = Rutine()
      ..name = nameController
      ..email = emailController
      ..address = ageController;
    await isar.writeTxn(() async {
      final newRoutine = await isar.rutines.put(addRoutine);
      // print(isar.rutines.name);
      print(newRoutine);
    });
  }

  static Future<List<Rutine>> readRoutine() async {
    return await isar.rutines.where().findAll();
  }

  static delete(id) async {
    await isar.writeTxn(() async {
      await isar.rutines.delete(id);
    });
  }
}
