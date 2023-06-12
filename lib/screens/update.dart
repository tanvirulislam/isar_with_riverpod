import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_with_riverpod/collections/rutine.dart';
import 'package:isar_with_riverpod/isar/isar_service.dart';
import 'package:isar_with_riverpod/provider/provider.dart';

// ignore: must_be_immutable
class UpdateScreen extends ConsumerWidget {
  final Rutine rutine;
  UpdateScreen({super.key, required this.rutine});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(rutine.name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: rutine.name),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(hintText: rutine.email),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(hintText: rutine.address),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                ref.read(rutineProvider.notifier).updateRutine(
                      rutine.id,
                      _nameController.text,
                      _emailController.text,
                      _addressController.text,
                    );

                // IsarService.updateRutine(
                //   rutine.id,
                //   _nameController.text,
                //   _emailController.text,
                //   _addressController.text,
                // );
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
