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
    required name,
    required email,
    required address,
  }) async {
    final addRoutine = Rutine()
      ..name = name
      ..email = email
      ..address = address;
    await isar.writeTxn(() async {
      await isar.rutines.put(addRoutine);
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

// update rutine
  static updateRutine(id, name, email, address) async {
    await isar.writeTxn(() async {
      final rutineId = await isar.rutines.get(id);
      rutineId!
        ..name = name
        ..email = email
        ..address = address;
      await isar.rutines.put(rutineId);
    });
  }

  // static watchRutine() {
  //   Stream<List<Rutine>> allRutine =
  //       isar.rutines.where().build().watch(fireImmediately: true);
  //   allRutine.listen((event) {
  //     if (event.length > 0) {
  //       final newEvent = isar.rutines.where().findAll();
  //       print(newEvent);
  //     }
  //   });
  // }

}

// final cartsStreamProvider = StreamProvider((ref) => isarDB.cartForLocalUsers
//     .filter()
//     .isrIdIsNotNull()
//     .build()
//     .watch(fireImmediately: true));
