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

  List<Rutine>? rutines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rutines = ref.watch(rutineProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Routine')),
      body: SingleChildScrollView(
        child: Padding(
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
                    nameController: _nameController.text,
                    emailController: _emailController.text,
                    ageController: _addressController.text,
                  );
                  clearText();
                },
                child: Text('Add'),
              ),
              SizedBox(height: 50),
            ],
          ),
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
