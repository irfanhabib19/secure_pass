import 'package:flutter/material.dart';
import '../models/password_model.dart';
import '../services/db_service.dart';

class PasswordProvider extends ChangeNotifier {
  List<PasswordModel> _passwords = [];

  List<PasswordModel> get passwords => _passwords;

  PasswordProvider() {
    fetchPasswords();
  }

  Future<void> fetchPasswords() async {
    _passwords = await DBService.getPasswords();
    notifyListeners();
  }

  void addPassword(PasswordModel password) async {
    await DBService.insertPassword(password);
    await fetchPasswords();
  }

  void updatePassword(PasswordModel password) async {
    await DBService.updatePassword(password);
    await fetchPasswords();
  }

  void deletePassword(int id) async {
    await DBService.deletePassword(id);
    await fetchPasswords();
  }
}
