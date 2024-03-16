import 'package:egtool/features/auth/screens/signup.dart';
import 'package:egtool/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:egtool/constants/global_variables.dart';

class SigninScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthService().checkifsignin(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.primarycolor,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth <= 0) {
                          return const SizedBox
                              .shrink(); // Return an empty widget if width is 0 or less
                        } else {
                          return Image.asset(
                            'images/logo-white.png',
                            height: 80,
                          );
// Replace this with your actual child widget
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  const DottedLine(
                    direction: Axis.vertical,
                    lineLength: 70, // Adjust this value as needed
                    lineThickness: 1.0,
                    dashLength: 7.0,
                    dashColor: Colors.white,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                  const SizedBox(width: 30),
                  const Text(
                    "Login",
                    style: TextStyle(
                        height: 3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 360,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Sign in to practice",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DottedLine(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 5.0,
                        dashColor: Color.fromRGBO(7, 127, 131, 1),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(
                              "Email  ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(
                              "Password  ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget password",
                              style: TextStyle(
                                color: Color.fromRGBO(7, 127, 131, 1),
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 47,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: GlobalVariables.Selected,
                          ),
                          onPressed: () {
                            signInUser();
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 130,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "New Users",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 47,
                        width: 500,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(
                                color: Color.fromRGBO(251, 191, 36, 40),
                                width: 2,
                              ),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(254, 243, 199, 40),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const signup()));
                          },
                          child: const Text(
                            "Create an Account",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
