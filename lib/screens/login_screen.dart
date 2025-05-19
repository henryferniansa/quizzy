import 'package:quiz/matpel.dart';
import 'package:quiz/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        print("User Data: ${userCredential.runtimeType}");
        print("User Info: ${userCredential.user}");
        print("User Data: ${userCredential.user?.email}");
        Fluttertoast.showToast(msg: "Login Successful");
        if (userCredential.user != null) {
          print("Login berhasil: ${userCredential.user?.email}");
        } else {
          print("User kosong, kemungkinan ada masalah parsing.");
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MataPelajaran()),
        );
      } on FirebaseAuthException catch (error) {
        String errorMessage = _getErrorMessage(error.code);
        Fluttertoast.showToast(msg: errorMessage);
        debugPrint("Error Code: ${error.code}");
      } catch (e) {
        Fluttertoast.showToast(msg: "Terjadi kesalahan: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Format email salah.";
      case "wrong-password":
        return "Kata sandi salah.";
      case "user-not-found":
        return "Akun tidak ditemukan.";
      case "user-disabled":
        return "Akun telah dinonaktifkan.";
      case "too-many-requests":
        return "Terlalu banyak percobaan login.";
      case "operation-not-allowed":
        return "Metode login belum diaktifkan.";
      default:
        return "Terjadi kesalahan.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: Image.asset("assets/images/login_bg.png", fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 45),
                  _buildEmailField(),
                  const SizedBox(height: 25),
                  _buildPasswordField(),
                  const SizedBox(height: 35),
                  _isLoading ? const CircularProgressIndicator() : _buildLoginButton(),
                  const SizedBox(height: 15),
                  _buildSignUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value!.isEmpty) return "Masukkan email";
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return "Format email tidak valid";
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value!.isEmpty) return "Password wajib diisi";
        if (!RegExp(r'^.{6,}$').hasMatch(value)) return "Password minimal 6 karakter";
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xff798777),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: signIn,
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Belum punya akun? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistrationScreen()),
            );
          },
          child: const Text(
            "Daftar",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
    );
  }
}