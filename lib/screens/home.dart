import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_with_riverpod/isar/isar_service.dart';
import 'package:isar_with_riverpod/provider/provider.dart';
import 'package:isar_with_riverpod/screens/update.dart';

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
        child: SingleChildScrollView(
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
                  clearText();
                },
                child: Text('Add'),
              ),
              SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: rutinesRef.when(
                  data: (data) {
                    return Column(
                      children: [
                        for (final rutine in data)
                          ListTile(
                            leading: Text(rutine.id.toString()),
                            title: Text(rutine.name.toString()),
                            trailing: SizedBox(
                              width: 100,
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
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateScreen(rutine: rutine),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
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
      ),
    );
  }
}
