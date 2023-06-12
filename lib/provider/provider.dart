import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_with_riverpod/collections/rutine.dart';
import 'package:isar_with_riverpod/isar/isar_service.dart';

final rutineProvider =
    AsyncNotifierProvider<RoutineNotifier, List<Rutine>>(RoutineNotifier.new);

class RoutineNotifier extends AsyncNotifier<List<Rutine>> {
  @override
  build() async {
    return fetchRutine();
  }

// fetch data

  Future<List<Rutine>> fetchRutine() async {
    return await IsarService.readRoutine();
  }

  // update data
  updateRutine(id, name, email, address) async {
    await isar.writeTxn(() async {
      final rutineId = await isar.rutines.get(id);
      rutineId!
        ..name = name
        ..email = email
        ..address = address;
      await isar.rutines.put(rutineId);
    });
  }

// delete data
  void delete(Id id) {
    IsarService.delete(id);
  }
}
