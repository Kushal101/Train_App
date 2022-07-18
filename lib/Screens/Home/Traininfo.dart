import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:train_app/Routemodel.dart';

import '../../QuotaModel.dart';
import '../../class model.dart';

class Traininfo extends StatefulWidget {
  const Traininfo({Key? key}) : super(key: key);

  @override
  State<Traininfo> createState() => _TraininfoState();
}

class _TraininfoState extends State<Traininfo> {
  get id {
    final Object? rcvdData = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    print("rcvd fdata ${rcvdData}");

    return rcvdData;
  }



  Future<List<Class>?> train() async {
    List<Class>? Classes;

    final response = await http.get(
      Uri.parse(
          'https://androgamesinfotech.com/temp/test.php?train=${id
              .toString()}'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var rest = data["data"]["class"] as List;
      Classes = rest
          .map<Class>((json) => Class.fromJson(json))
          .cast<Class>()
          .toList();
      print("List Size: ${Classes.length}");
      print(Classes);
      return Classes;
    }
    return null;
  }

  Future<List<Quota>?> TrainQuota() async {
    List<Quota>? quota;

    final response = await http.get(
      Uri.parse(
          'https://androgamesinfotech.com/temp/test.php?train=${id.toString()}'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var rest = data["data"]["quota"] as List;
      quota = rest
          .map<Quota>((json) => Quota.fromJson(json))
          .cast<Quota>()
          .toList();
      print("List Size: ${quota.length}");
      print(quota);
      return quota;
    }
    return null;
  }
  Future<List<RouteModel>?> TrainRoute() async {

    List<RouteModel> route;

    final response = await http.get(
      Uri.parse(
          'https://androgamesinfotech.com/temp/test.php?train=${id.toString()}'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      var rest = data["data"]["route"] as List;
      route = rest
          .map<RouteModel>((json) => RouteModel.fromJson(json))
          .cast<RouteModel>()
          .toList();
      print("List Size: ${route.length}");
      print(route);
      return route;
    }
    return null;
  }
  @override
  void initState() {
    Future.delayed(Duration.zero, ()

    {
      this.train();
      this.TrainQuota();
      this.TrainRoute();
      //this.buildmenucalender(context);
    });

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }

  Widget TrainClass(List<Class> events)  {
    return  AlertDialog(
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(events[index].name.isNotEmpty
                          ? events[index].name
                          : "Loading..",style:TextStyle(fontSize:20) ,),
                      subtitle:Text(events[index].value.isNotEmpty?
                      events[index].value:"Loading....",style:TextStyle(fontSize:15) ,)  ,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider( color: Colors.black,
                      thickness: 1,);
                  },
                  itemCount: events.length),
            ),
  );


  }

  Widget railQuota(List<Quota> events) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(events[index].name.isNotEmpty
                    ? events[index].name
                    : "Loading..", style: TextStyle(fontSize: 20),),
                subtitle: Text(events[index].value.isNotEmpty ?
                events[index].value : "Loading....",
                  style: TextStyle(fontSize: 15),),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.black,
                thickness: 1,);
            },
            itemCount: events.length),
      ),
    );
  }

  buildQuotaContainer(BuildContext context) {
    showDialog(
        context: context,

        builder: (BuildContext context) {
          return Container(
              child: FutureBuilder(
                  future: TrainQuota(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? railQuota(snapshot.data as List<Quota>)
                        : Center(child: CircularProgressIndicator());
                  }));
        }
    );}

  buildHelpContainer(BuildContext context) {
    showDialog(
        context: context,

        builder: (BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: train(),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? TrainClass(snapshot.data as List<Class>)
                  : Center(child: CircularProgressIndicator());
            }));
  }
    );}

  Widget Menucalender(List<RouteModel>? events) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Container(width: 399);
        },
        itemBuilder: (BuildContext context, position) {
          return Container(
              height: 230,
              child: Stack(children: [
                Container(
                  margin: EdgeInsets.only(top: 15, right: 10, left: 31),
                  height: 50,
                  width: 800,
                  child: Stack(children: <Widget>[
                    Align(
                        alignment: const Alignment(-1, -1),
                        child: Text(
                          "Day :${events?[position].day}".isNotEmpty
                              ? "Day :${events?[position].day}"
                              : "Loading..",
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.start,
                        )),
                    Align(
                        alignment: const Alignment(-0.90, 1),
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 1.5,
                          indent: 30,
                          endIndent: 10,
                        )),
                    Align(
                        alignment: const Alignment(0, -0.8),
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                          indent: 90,
                          endIndent: 5,
                        ))
                  ]),
                ),
                IntrinsicHeight(
                    child: Stack(children: [
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                      top: 60,
                    ),
                    child: Stack(children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                left: 15,
                                right: 0,
                              ),
                              height: 60,
                              width: 93,
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: const Alignment(0, -0.50),
                                  child: Text.rich(TextSpan(
                                    text: "${events?[position].stationcode}".isNotEmpty
                                        ? "${events?[position].stationcode}"
                                        : "Loading..",
                                    style: Theme.of(context).textTheme.subtitle2,
                                  )),
                                ),

                              ]),
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 0, right: 14, left: 10, bottom: 5.0),
                              width: 278,

                              child: Stack(children: <Widget>[
                                Align(
                                    alignment: const Alignment(-1, -0.99),
                                    child: Text(
                                      'Station : ${events?[position].stationname}(${events?[position].stationcode})'.isNotEmpty?
                                      'Station : ${events?[position].stationname}(${events?[position].stationcode})':"Loading...",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.left,
                                    )),
                                Align(
                                    alignment: const Alignment(-1, -0.7),
                                    child: Text(
                                      "State : ${events?[position].statename}(${events?[position].statecode})".isNotEmpty?
                                      "State : ${events?[position].statename}(${events?[position].statecode})":"Loading...",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.end,
                                    )),
                                Positioned(
                                    top: 45,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "Platform no : ${events?[position].platformnumber}".isNotEmpty?
                                      "Platform no : ${events?[position].platformnumber}":"Loading",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                                Positioned(
                                    top: 65,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "Distance From Source : ${events?[position].distancefromSource} Km".isNotEmpty
                                      ?"Distance From Source : ${events?[position].distancefromSource} Km":"Loading...",
                                      style:
                                      Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                                Positioned(
                                    top: 85,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "Stoppage : ${events?[position].stop}".isNotEmpty?
                                      "Stoppage : ${events?[position].stop}":"Loading...",
                                      style:
                                      Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                                Positioned(
                                    top: 105,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "longitude : ${events?[position].longitude}".isNotEmpty?
                                      "longitude : ${events?[position].longitude}":"Loading..." ,
                                      style:
                                      Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                                Positioned(
                                    top: 125,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "latitude : ${events?[position].latitude}".isNotEmpty?
                                      "latitude : ${events?[position].latitude}":"Loading...",
                                      style:
                                      Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                                Positioned(
                                    top: 145,
                                    right: 0,
                                    left: 0,
                                    child: Text(
                                      "Train Started From  : ${events?[position].trainsource}".isNotEmpty?
                                      "Train Started From  : ${events?[position].trainsource}":"Loading...",
                                      style:
                                      Theme.of(context).textTheme.subtitle2,
                                      textAlign: TextAlign.start,
                                    )),
                              ]),
                            ),
                          ]),
                      const Positioned(
                        child: Align(
                            alignment: Alignment(-0.75, 1),
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1.5,
                              indent: 75,
                              endIndent: 20,
                            )),
                      )
                    ]),
                  )
                ]))
              ]));
        });
  }
  buildmenucalender(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: TrainRoute(),
            builder: (context, snapshot) {
    return snapshot.data != null
    ? Menucalender(snapshot.data as List<RouteModel>?)
        : Center(child: CircularProgressIndicator());
  }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text("Train no:  $id",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            FlatButton.icon(
                onPressed: () { Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);},
                icon: const Icon(Icons.search),
                label: const Text("Search"))
          ],
        ),
        body: SingleChildScrollView(child:Container(
          child: Stack(children:[
            Container(
                height: 160,
                width: 396,
                margin: EdgeInsets.only(
                  top: 20,
                  right: 10,
                  left: 10,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

              child:Stack(children:[
            const Positioned(
              top:99,
                left: 10,
                child: Text("Coach Information :",style: TextStyle(fontSize:25,fontWeight:FontWeight.w600  ),)),
            Padding(
              padding:const EdgeInsets.only(
                top:90,
                left:260,
                right: 5,
                bottom: 5,

              ),
              child: ElevatedButton(
                onPressed: () async{
                 await buildHelpContainer(context);
                },
                child: Text('Search Coach',
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
              )),
            const Positioned(
                top:37,
                left: 10,
                child: Text("Quota Information :",style: TextStyle(fontSize:25,fontWeight:FontWeight.w600  ),)),
            Padding(
                padding:const EdgeInsets.only(
                  top:30,
                  left:260,
                  right: 10,
                  bottom: 5,

                ),
                child: ElevatedButton(
                  onPressed: () async{
                    await buildQuotaContainer(context);
                  },
                  child: Text('Search quota',
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
                )),
            ])),
            Container(
              margin: EdgeInsets.only(
                top: 200,
                 left: 20,
                bottom: 4,
              ),
              child: Text("Train Route :",style: TextStyle(fontSize:25,fontWeight:FontWeight.w600  ),),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 220,

                bottom: 4,
              ),

              child:
            buildmenucalender(context),
            )
    ]))));
  }
}
