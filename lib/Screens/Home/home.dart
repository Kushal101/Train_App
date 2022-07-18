import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Auth service.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  get paramter{
    return _controller.text;
  }
  final TextEditingController _controller = TextEditingController();
  String Model="";



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

  @override
  Widget build(BuildContext context) {

    AuthService _auth =AuthService();
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text("Welcome to Train app",style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold )),
          actions: [
            FlatButton.icon(onPressed: () async {
              await _auth.SignOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
              '/SignIn', (Route<dynamic> route) => false);
          }, icon:const Icon(Icons.person), label: const Text("logout") )

          ],
    ),
    body: Container(
      margin: const EdgeInsets.only(
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
               Model= _controller.text.toString()  ;
                _controller.clear();
                FocusScope.of(context).requestFocus(FocusNode());

                setState(() {
                  _controller.clear();
                  Model;
                });
               Navigator.pushNamed(context,'/Traininfo',arguments:Model.toString(),);

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
