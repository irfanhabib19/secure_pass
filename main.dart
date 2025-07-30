import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/password_provider.dart';
import 'screens/home_screen.dart';
import 'auth/pin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PasswordProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Password Manager',
        theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
        home: const PinScreen(),
      ),
    );
  }
}
