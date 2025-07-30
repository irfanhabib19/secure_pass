import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/password_provider.dart';
import '../widgets/password_tile.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PasswordProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Password Manager')),
      body: provider.passwords.isEmpty
          ? const Center(child: Text('No passwords saved yet'))
          : ListView.builder(
              itemCount: provider.passwords.length,
              itemBuilder: (context, index) {
                final item = provider.passwords[index];
                return PasswordTile(password: item);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
