import 'package:amazon_clone/common/widgets/customTextfield.dart';
import 'package:amazon_clone/common/widgets/custombutton.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/features/auth/services/authservices.dart';
import 'package:flutter/material.dart';

enum Auth {
  sigin,
  signup,
}

class authScreen extends StatefulWidget {
  const authScreen({super.key});
  static const routeName = '/auth-screen';
  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signupUser() {
    authService.signUpService(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void signinUser() {
    authService.signInService(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text("Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintTxt: 'Name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintTxt: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintTxt: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          txt: 'Sign Up',
                          ontap: () {
                            if (_signupFormKey.currentState!.validate()) {
                              signupUser();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.sigin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text("Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Radio(
                value: Auth.sigin,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
              ),
            ),
            if (_auth == Auth.sigin)
              Container(
                color: GlobalVariables.backgroundColor,
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintTxt: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintTxt: 'Password',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          txt: 'Sign In',
                          ontap: () {
                            if (_signinFormKey.currentState!.validate()) {
                              signinUser();
                            }
                          })
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
