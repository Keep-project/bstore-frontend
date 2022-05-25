

import 'dart:convert';

class TokenReponseModel{

  TokenReponseModel({this.access, this.refresh});

  final String? access;
  final String? refresh;

  factory TokenReponseModel.fromJson(String string) => TokenReponseModel.fromMap(json.decode(string));

  factory TokenReponseModel.fromMap(Map<String, dynamic> json) => TokenReponseModel(
    access: json['access'] == null ? "" : json['access'],
    refresh: json['refresh'] == null ? "" : json['refresh'],
  );

  Map<String, dynamic> toMap() => {
    'access': access == null ? "" : access,
    'refresh': refresh == null ? "" : refresh,
  };
  
  String toJson() => json.encode(toMap());
}