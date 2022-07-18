class Quota {
  Quota({
    required this.value,
    required this.name,

  });

  String value;
  String name;


  factory Quota.fromJson(Map<String, dynamic> json) => Quota(
    value: json["value"],
    name: json["name"],

  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "name": name,

  };

}