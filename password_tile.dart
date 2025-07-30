import 'package:flutter/material.dart';
import '../models/password_model.dart';
import '../screens/add_edit_screen.dart';
import 'package:flutter/services.dart';

class PasswordTile extends StatelessWidget {
  final PasswordModel password;
  const PasswordTile({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(password.title),
      subtitle: Text(password.username),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: password.password));
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Password Copied')));
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditScreen(password: password)),
        );
      },
    );
  }
}
