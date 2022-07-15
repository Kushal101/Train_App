import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Models/train_no_model.dart';
import '../Auth service.dart';
import 'package:http/http.dart'as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  String Model="";
  Future<String?> train(String number) async {


    var response = await http.post(
        Uri.parse( 'https://androgamesinfotech.com/temp/test.php?train=<${_controller.text}>'),
        headers:{
          "Content-Type": "application/json",

        },
        body:jsonEncode({"data":_controller.text}));
    var data =response.body.toString();
    Model =response.body;
    print (data);
    print(response.statusCode);

    if (response.statusCode == 201) {
      String rest = response.body;
      sendFromJson(rest);
      print(rest);
        return Model;

    } else {

      return null;
    }

  }
  buildLanguageDialog(BuildContext context)  {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            content: Container(
              width: double.infinity,
              child:Text(Model)

            ),
          );
        });

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Future<Trainno>? futureAlbum;
  @override
  Widget build(BuildContext context) {

    AuthService _auth =AuthService();
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("Welcome to Train app",style: const TextStyle(color:Colors.black,fontWeight:FontWeight.bold )),
          actions: [
            FlatButton.icon(onPressed: () async {
              await _auth.SignOut();
          }, icon:Icon(Icons.person), label: Text("logout") )

          ],
    ),
    body: Container(
      margin: EdgeInsets.only(
        top: 100.0,
      ),
    child: Column(
      children: [
     Padding(
         padding:  EdgeInsets.only(
    left: 10,
      right: 10,
      bottom: 5,

    ),
         child:TextField(
           controller: _controller,
           maxLength: 5,
           inputFormatters:[
             LengthLimitingTextInputFormatter(5),
             FilteringTextInputFormatter.digitsOnly
           ],
           keyboardType: TextInputType.number,

           decoration: InputDecoration(

        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomLeft:
              Radius.circular(10.0),
              bottomRight:
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Theme.of(context)
                  .dividerColor,
            )),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Please enter train no ...',
        hintStyle: Theme.of(context)
            .textTheme
            .subtitle1,

      ),
    )
     ),
        Padding(
            padding:EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 5,

            ),
            child: ElevatedButton(
              onPressed: () async{
                futureAlbum =await train(_controller.text) as Future<Trainno>? ;
                _controller.clear();
                FocusScope.of(context).requestFocus(FocusNode());
                buildLanguageDialog(context);
                setState(() {
                  _controller.clear();
                });
              },
              child: Text('Submit',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white),
                shape:
                MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            )),],
    ),

    ));
  }
}
