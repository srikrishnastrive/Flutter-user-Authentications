import 'package:firebase_project/Login/sign_up.dart';
import 'package:firebase_project/home/forgot_password.dart';
import 'package:firebase_project/home/home_screen.dart';
import 'package:firebase_project/home/phone_login.dart';
import 'package:firebase_project/services/authentication.dart';
import 'package:firebase_project/services/google_authentication.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:firebase_project/widgets/snack_bar.dart';
import 'package:firebase_project/widgets/text_field.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void Signinuser() async {
    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
    }
    showSnackBar(context, res);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height / 2.7,
              width: double.infinity,
              child: Image.asset('images/login.jpg'),
            ),
            TextFieldInput(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.email),
            TextFieldInput(
              textEditingController: passwordController,
              hintText: "Password",
              icon: Icons.password,
              isPass: true,
            ),
            const ForgotPassword(),
            MyButton(onTap: Signinuser, text: "Login"),
            SizedBox(
              height: height / 30,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.black,
                )),
                const Text("  or  "),
                Expanded(
                    child: Container(
                  height: 1,
                  color: Colors.black,
                ))
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: () async {
                  try {
                    final user = await _firebaseServices.signInWithGoogle();
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    } else {
                      print('Sign-in was canceled');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign-in canceled')),
                      );
                    }
                  } catch (e) {
                    print('Error: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sign-in failed: $e')),
                    );
                  }
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Image.network(
                        "https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                        height: 35,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PhoneAuthentication(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: const Text(
                    ' SignUp',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
