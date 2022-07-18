import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:train_app/Screens/Auth%20service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text("SignIn to Train app",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
            child: Stack(children: [
          Positioned(
              top: 450,
              left: 160,
              bottom: 100,
              child: ElevatedButton(
                  onPressed: () async {
                    dynamic result = await _authService.signInAnon();
                    if (result == null) {
                      print("error signing in");
                    } else {
                      print('signed in ');
                      print(result);
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 22, color: Colors.black),
                  ))),
          Positioned(
            top: 100,
            right: 50,
            left: 50,
            bottom: 250,
            child: Container(
              color: Colors.amberAccent,
              child: Icon(
                Icons.directions_train_outlined,
                size: 250,
              ),
            ),
          )
        ])));
  }
}
