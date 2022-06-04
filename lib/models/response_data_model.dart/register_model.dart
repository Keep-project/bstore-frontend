// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class RegisterResponseModel {
  final int? status;
  final bool? success;
  final String? message;
  final User? results;

  RegisterResponseModel(
      {this.status, this.success, this.message, this.results});

  factory RegisterResponseModel.fromJson(String string) =>
      RegisterResponseModel.fromMap(json.decode(string));

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json['status'] ?? 0,
        success: json['success'] ?? true,
        message: json['message'] ?? "",
        results: json['results'] == null ? null : User.fromMap(json['results']),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'success': success,
        'message': message,
        'results': results,
      };

  String toJson() => json.encode(toMap());
}

class User {
  final int? id;
  final String? username;
  final String? prenom;
  final String? nom;
  final String? avatar;
  final String? email;
  final bool? is_staff;
  final bool? is_active;
  final DateTime? date_joined;

  User(
      {this.id,
      this.username,
      this.prenom,
      this.nom,
      this.avatar,
      this.email,
      this.is_staff,
      this.is_active,
      this.date_joined});

  factory User.fromJson(String string) => User.fromMap(json.decode(string));
  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'] ?? 0,
        username: json['username'] ?? "",
        prenom: json['prenom'] ?? "",
        nom: json['nom'] ?? "",
        avatar: json['get_avatar_url'] ?? "",
        is_staff: json['is_active'] ?? true,
        is_active: json['is_active'] ?? true,
        date_joined: DateTime.parse(json['date_joined']),
      );

      Map<String,dynamic> toMap() => {
        'id':id,
        'username':username,
        'prenom':prenom,
        'nom': nom,
        'avatar':avatar,
        'email':email,
        'is_staff': is_staff,
        'is_active': is_active,
        'date_joined': date_joined ,

      };

      String toJson() => json.encode(toMap());
}
