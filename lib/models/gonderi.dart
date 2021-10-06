import 'dart:convert';

Gonderi gonderiFromJson(String str) => Gonderi.fromJson(json.decode(str));

String gonderiToJson(Gonderi data) => json.encode(data.toJson());

class Gonderi {
  Gonderi({
    required this.data,
    required this.resultType,
    required this.description,
  });

  List<String> data;
  int resultType;
  String description;

  factory Gonderi.fromJson(Map<String, dynamic> json) => Gonderi(
        data: List<String>.from(json["Data"].map((x) => x)),
        resultType: json["ResultType"],
        description: json["Description"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x)),
        "ResultType": resultType,
        "Description": description,
      };
}
