import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_app/Models/Usermodel.dart';
import 'package:train_app/Screens/Authenticate/authenticate.dart';
import 'package:train_app/Screens/Home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user =Provider.of<MyUser?>(context);
    print (user);
    if(user==null) {
      return Authenticate();
    }else{
      return  Home();
    }
  }
}
