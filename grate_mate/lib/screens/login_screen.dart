import 'package:flutter/material.dart';
import 'package:grate_mate/models/user.dart';
import 'package:grate_mate/widgets/mate_error_text.dart';
import 'package:grate_mate/widgets/mate_text_p.dart';

import '../global_information/colors_palette.dart';
import '../global_information/global_users.dart' as Users;
import '../widgets/mate_text_h1.dart';
import 'about_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  bool _errorLogin = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Scaffold(
        backgroundColor: GrateMate.grayGrateMate,
        //SingleChildScrollView otherwise screen overflow due to keyboard popping up
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: MateTextH1(
                    text: 'Log in',
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MateTextP(
                          text: 'Email',
                        ),
                        TextFormField(
                            controller: _emailController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontFamily: 'MontSerrat',
                              fontSize: 14,
                            ),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        const MateTextP(
                          text: 'Password',
                        ),
                        TextFormField(
                            controller: _passwordController,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontFamily: 'MontSerrat',
                              fontSize: 14,
                            ),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        _errorLogin
                            ? const MateTextError(
                                text: 'Invalid email or password',
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  GrateMate.yellowNorthFace),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  User loggedUser = Users.users.firstWhere(
                                      (user) =>
                                          user.email == email &&
                                          user.password == password,
                                      orElse: () => User(id: -1));
                                  if (loggedUser.id == -1) {
                                    _errorLogin = true;
                                  } else {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                    Users.isLogged = true;
                                    Users.userLogged = loggedUser;
                                  }
                                }
                              });
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          child: const MateTextP.hyperLink(
                              text: 'About GrateMate'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutScreen()),
                            );
                          },
                        )
                      ],
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
