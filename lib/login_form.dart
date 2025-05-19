import 'package:flutter/material.dart';
import 'matpel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with WidgetsBindingObserver {

  bool keyboardVisible = false; // State untuk mendeteksi keyboard

  @override
  void initState() {
    super.initState();
    // Mendaftarkan observer agar bisa mendeteksi perubahan metrics
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    // Mengambil nilai view insets dari window
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0.0;
    // Hanya update state jika terjadi perubahan nyata
    if (isKeyboardVisible != keyboardVisible) {
      setState(() {
        keyboardVisible = isKeyboardVisible;
      });
    }
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    // Hapus observer saat widget di dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8EDE3),
          elevation: 0,
          title: const Text(
            "Login",
            style: TextStyle(
              fontSize: 40,
              color: Color(0xff798777),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // Animasi hanya mengubah padding bawah sesuai state keyboardVisible
            padding: EdgeInsets.only(
              bottom: keyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Image.asset('assets/images/login_bg.png'),
                ),
                Column(
                  children: [
                    Container(
                      width: 245,
                      height: 60,
                      margin: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nama',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 11,
                            horizontal: 15,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: 245,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'NIM',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 11,
                            horizontal: 15,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(Color(0xff798777)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        minimumSize: const WidgetStatePropertyAll(Size(245, 60)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MataPelajaran()),
                        );
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}