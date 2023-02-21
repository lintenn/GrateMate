import 'package:flutter/material.dart';
import 'package:grate_mate/models/user.dart';

import '../global_information/colors_palette.dart';
import '../global_information/global_users.dart' as Users;

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
    return Scaffold(
      backgroundColor: GrateMate.grayGrateMate,
      body: Container(
        margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: [
                  Column(
                    children: const [
                      Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'MontserratExtraBold',
                          //color: GrateMate.darkGrateMate
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //color: GrateMate.darkGrateMate
                              ),
                            ),
                          ],
                        ),
                      ],
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
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Montserrat',
                                //color: GrateMate.darkGrateMate
                              ),
                            ),
                          ],
                        ),
                      ],
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
                    ),
                    const SizedBox(height: 16,),
                    _errorLogin?
                    const Text(
                      'Invalid email or password',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0
                      ),
                    )
                    :
                    Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(GrateMate.yellowNorthFace),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              User loggedUser = Users.users.firstWhere((user) => user.email == email && user.password == password, orElse: () => User(id: -1));
                              if(loggedUser.id == -1){
                                _errorLogin = true;
                              }else{
                                print('here');
                                Navigator.pushReplacementNamed(context, '/home');
                                Users.isLogged = true;
                                Users.userLogged = loggedUser;
                              }
                            }
                          });
                        },
                        child: const Text('Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}