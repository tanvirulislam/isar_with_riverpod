import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_with_riverpod/collections/rutine.dart';
import 'package:isar_with_riverpod/isar/isar_service.dart';

final rutineProvider =
    NotifierProvider<RoutineNotifier, List<Rutine>>(RoutineNotifier.new);

class RoutineNotifier extends Notifier<List<Rutine>> {
  @override
  build() {
    return [];
  }

  static Future<List<Rutine>> fetchRutine() async {
    return await IsarService.readRoutine();
  }

  void delete(Id id) {
    IsarService.delete(id);
  }
}
