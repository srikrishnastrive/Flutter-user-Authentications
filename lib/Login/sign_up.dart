import 'package:firebase_project/Login/login.dart';
import 'package:firebase_project/home/home_screen.dart';
import 'package:firebase_project/services/authentication.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:firebase_project/widgets/snack_bar.dart';
import 'package:firebase_project/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    String res = await AuthServices().singUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);

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
              child: Image.asset('images/signup.jpeg'),
            ),
            TextFieldInput(
                textEditingController: nameController,
                hintText: "Name",
                icon: Icons.person),
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
            MyButton(onTap: signupUser, text: "Signup"),
            SizedBox(
              height: height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Loginscreen()));
                  },
                  child: const Text(
                    ' Login',
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
