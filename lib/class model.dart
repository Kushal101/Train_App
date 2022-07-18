class Class {
  Class({
    required this.value,
    required this.name,

  });

  String value;
  String name;


  factory Class.fromJson(Map<String, dynamic> json) => Class(
    value: json["value"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "name": name,

  };
}