import 'package:flutter/material.dart';
import 'constants.dart'; // Pastikan di file constants.dart Anda mendefinisikan mtkQuizURL, bioQuizURL, fisikaQuizURL, kimiaQuizURL
import 'package:quiz/screens/generic_quiz_screen.dart';

class MataPelajaran extends StatelessWidget {
  const MataPelajaran({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar mata pelajaran yang berisi nama, URL untuk database soal, dan path gambar masing-masing.
    final List<Map<String, String>> subjects = [
      {
        'name': 'Matematika',
        'image': 'assets/images/matematika.png',
        'url': mtkQuizURL,
      },
      {
        'name': 'Biologi',
        'image': 'assets/images/biologi.png',
        'url': bioQuizURL,
      },
      {
        'name': 'Fisika',
        'image': 'assets/images/fisika.png',
        'url': fisikaQuizURL,
      },
      {
        'name': 'Kimia',
        'image': 'assets/images/kimia.png',
        'url': kimiaQuizURL,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff798777),
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          GridView.count(
            primary: false,
            padding: const EdgeInsets.only(
                right: 30, left: 30, bottom: 30, top: 50),
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: subjects.map((subject) {
              return TextButton(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        subject['image']!,
                        height: 110,
                        width: 125,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        subject['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigasi ke GenericQuizScreen dengan parameter yang sesuai.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GenericQuizScreen(
                            subject: subject['name']!,
                            databaseUrl: subject['url']!,
                          )));
                },
              );
            }).toList(),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.only(top: 40),
            child: const Text(
              'Pilih Mata Pelajaran',
              style: TextStyle(
                fontSize: 35,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}