import 'package:authentication/screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Pengajuan Judul Skripsi',
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      // initialRoute: '/login',
      // routes: {
      //   '/login': (context) => LoginScreen(),
      // },
      home: LoginScreen(),
    );
  }
}
