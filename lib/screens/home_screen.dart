import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/matpel.dart';
import 'package:quiz/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mendapatkan user yang sudah login
  final User? user = FirebaseAuth.instance.currentUser;

  // Instance dari UserModel untuk menyimpan data pengguna dari Firestore

  late UserModel loggedInUser ;

  // Variabel flag loading untuk menampilkan indikator progress
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Jika user tidak null, ambil data pengguna
    if (user != null) {
      _loadUserData();
    } else {
      // Jika tidak ada user, langsung diarahkan ke tampilan Login
      Future.microtask(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  // Fungsi untuk mengambil data user dari Firestore
  Future<void> _loadUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get();
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          loggedInUser = UserModel.fromMap(data);
          _isLoading = false;
        });
      } else {
        // Jika data tidak ditemukan, set _isLoading ke false dan log pesan/handling khusus
        setState(() {
          _isLoading = false;
        });
        debugPrint("Data pengguna tidak ditemukan.");
      }
    } catch (error) {
      debugPrint("Error mengambil data user: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Fungsi logout, membersihkan session dan mengarahkan ke LoginScreen
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar profil atau logo
              SizedBox(
                height: 150,
                child: Image.asset("assets/images/pp.png", fit: BoxFit.contain),
              ),
              const SizedBox(height: 15),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Menampilkan nama lengkap pengguna (gabungan firstName dan secondName)
              Text(
                "${loggedInUser.firstName ?? ''} ${loggedInUser.secondName ?? ''}",
                style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              // Menampilkan alamat email pengguna
              Text(
                loggedInUser.email,
                style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              // Tombol untuk navigasi ke katalog mata pelajaran
              ActionChip(
                label: const Text("Lihat Katalog"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MataPelajaran()),
                  );
                },
              ),
              const SizedBox(height: 10),
              // Tombol logout
              ActionChip(
                label: const Text("Logout"),
                onPressed: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}