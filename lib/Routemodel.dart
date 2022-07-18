



class RouteModel {
  RouteModel({
    required this.day,
    required this.distancefromSource,
    required this.latitude,
    required this.longitude,
    required this.platformnumber,
    required this.statecode,
    required this.statename,
    required this.stationcode,
    required this.stationname,
    required this.stop,
    required this.trainsource,
    required this.stationno,
  });

  int? day;
  String? distancefromSource;
  String? latitude;
  String? longitude;
  int? platformnumber;
  String? statecode;
  String? statename;
  String? stationcode;
  String? stationname;
  bool? stop;
  String? trainsource;
  int? stationno;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    day: json["day"] ,
    distancefromSource: json["distance_from_source"],
    latitude:json["lat"],
    longitude:json["lng"],
    platformnumber:json["platform_number"] ,
    statecode:json["state_code"],
    statename:json["state_name"],
    stationcode:json["station_code"],
    stationname:json["station_name"],
    stop:json["stop"] ,
    trainsource:json["train_src"],
    stationno:json["std_min"],

  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "distance_from_source": distancefromSource,
    "lat":latitude,
    "lng":longitude,
    "platform_number":platformnumber,
    "state_code":statecode,
    "state_name":statename,
    "station_name":stationname,
    "stop":stop,
    "train_src":trainsource,
    "std_min":stationno,
    "station_code":stationcode,

  };
}

