import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:quiz/theme.dart';
import 'models/connect_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    // Inisialisasi database dengan list instance DBConnect
    final dbInstances = [
      DBConnect('https://quiz-apps-77a13-default-rtdb.asia-southeast1.firebasedatabase.app/question.json'),
      DBConnect('https://quiz-apps-77a13-default-rtdb.asia-southeast1.firebasedatabase.app/question2.json'),
      DBConnect('https://quiz-apps-77a13-default-rtdb.asia-southeast1.firebasedatabase.app/question3.json'),
      DBConnect('https://quiz-apps-77a13-default-rtdb.asia-southeast1.firebasedatabase.app/question4.json'),
    ];

    await Future.wait(dbInstances.map((db) => db.fetchQuestion()));

    runApp(MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    ),

    );
  } catch (e) {
    debugPrint('Initialization error: $e');
    // Di sini kamu bisa menampilkan UI error dengan widget tertentu jika diperlukan
  }
}

