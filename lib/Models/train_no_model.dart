import 'dart:convert';


Trainno sendFromJson(String str)=>Trainno.fromJson(json.decode(str));
String sendToJson(Trainno data)=>json.encode(data.toJson());


class Trainno {

  String number;


  Trainno( { required this.number,});

  factory Trainno.fromJson(Map<String, dynamic> json)=> Trainno(

    number: json["data"].toString(),

  );
  Map<String, dynamic> toJson()=> {
    "data" : number,

  };
}