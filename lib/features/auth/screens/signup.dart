import 'package:egtool/features/auth/screens/signin.dart';
import 'package:egtool/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final AuthService authService = AuthService();
  
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(7, 127, 131, 1),
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text(
                "Create an Account",
                style: TextStyle(
                    height: 3,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 360,
                width: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3))
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
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Text(
                              "Name  ",
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
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 20,
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
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 5, top: 10, left: 380),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 47,
                              width: 100,
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
                                          builder: (context) => const SigninScreen()));
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 47,
                              width: 180,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(224, 156, 8, 1),
                                ),
                                onPressed: () {
                                  signUpUser();
                                },
                                child: Text(
                                  "Create Account",
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
