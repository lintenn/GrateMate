import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value != null) {
                  return 'Please write your email';
                }
                email = value!;
                return null;
              },
            ),
            TextFormField(
              //TODO: true para que no se vea la contrasenha
              obscureText: false,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value != null) {
                  return 'Please write your password';
                }
                password = value!;
                return null;
              },
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              child: Text('Log in'),
              onPressed: () {

                if (_formKey.currentState!.validate()) {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // TODO: Authentication logic
                  print('Email: $email, Contraseña: $password');
                }
                
              },
            ),
          ],
        ),
      ),
    );
  }
}