import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/password_model.dart';
import '../providers/password_provider.dart';
import '../utils/categories.dart';

class AddEditScreen extends StatefulWidget {
  final PasswordModel? password;
  const AddEditScreen({super.key, this.password});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _username;
  late TextEditingController _password;
  late TextEditingController _url;
  late TextEditingController _notes;
  String _category = 'Others';

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.password?.title ?? '');
    _username = TextEditingController(text: widget.password?.username ?? '');
    _password = TextEditingController(text: widget.password?.password ?? '');
    _url = TextEditingController(text: widget.password?.url ?? '');
    _notes = TextEditingController(text: widget.password?.notes ?? '');
    _category = widget.password?.category ?? 'Others';
  }

  @override
  void dispose() {
    _title.dispose();
    _username.dispose();
    _password.dispose();
    _url.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final newEntry = PasswordModel(
        id: widget.password?.id,
        title: _title.text.trim(),
        username: _username.text.trim(),
        password: _password.text.trim(),
        category: _category,
        url: _url.text.trim(),
        notes: _notes.text.trim(),
      );

      final provider = Provider.of<PasswordProvider>(context, listen: false);
      if (widget.password == null) {
        provider.addPassword(newEntry);
      } else {
        provider.updatePassword(newEntry);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.password == null ? 'Add Password' : 'Edit Password'),
        actions: [
          if (widget.password != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<PasswordProvider>(
                  context,
                  listen: false,
                ).deletePassword(widget.password!.id!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller: _url,
                decoration: const InputDecoration(labelText: 'URL'),
              ),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _category,
                items: categories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
