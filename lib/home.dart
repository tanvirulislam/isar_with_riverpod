import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_with_riverpod/collections/rutine.dart';
import 'package:isar_with_riverpod/isar/isar_service.dart';
import 'package:isar_with_riverpod/provider/provider.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  clearText() {
    _addressController.clear();
    _nameController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rutinesRef = ref.watch(rutineProvider);
    print('build');

    return Scaffold(
      appBar: AppBar(title: Text('Routine')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(hintText: 'Address'),
            ),
            ElevatedButton(
              onPressed: () {
                IsarService.addRoutine(
                  name: _nameController.text,
                  email: _emailController.text,
                  address: _addressController.text,
                );
                // ref.read(rutineProvider.notifier).addRutine(rutinesRef);
                clearText();
              },
              child: Text('Add'),
            ),
            SizedBox(height: 50),
            Container(
              height: 400,
              alignment: Alignment.center,
              // color: Colors.grey.shade200,
              child: rutinesRef.when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final rutine in data)
                          ListTile(
                            leading: Text(rutine.id.toString()),
                            title: Text(rutine.name.toString()),
                            trailing: SizedBox(
                              width: 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(rutineProvider.notifier)
                                          .delete(rutine.id);
                                    },
                                    icon: Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //   readRoutine() async {
  //   final newRutines = await isar.rutines.where().findAll();
  //   setState(() {
  //     rutines = newRutines;
  //   });
  //   print("length-------------${rutines.length}");
  // }
}
