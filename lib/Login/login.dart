import 'package:firebase_project/Login/sign_up.dart';
import 'package:firebase_project/home/forgot_password.dart';
import 'package:firebase_project/home/home_screen.dart';
import 'package:firebase_project/services/authentication.dart';
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
              height: height / 15,
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
