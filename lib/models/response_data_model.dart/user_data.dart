import 'dart:convert';

import 'package:bstore/models/response_data_model.dart/livre_model.dart';

class UserRequestModel {
  final bool? success;
  final String? message;
  final User? results;

  UserRequestModel({this.success, this.message, this.results});

  factory UserRequestModel.fromJson(String string) => UserRequestModel.fromMap(json.decode(string));

  factory UserRequestModel.fromMap(Map<String, dynamic> json) => UserRequestModel(
    success: json['success'] ?? false,
    message: json['message'] ?? '',
    results: json['results'] == null ? null : User.fromMap(json['results']),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "results": results
  };

  String toJson() => json.encode(toMap());
}

class User {
  
  User(
      {this.id,
      this.username,
      this.avatar,
      this.email,
      this.dateJoined,
      this.userPermissions,
      this.likedBooks,
      this.downloadsBooks,
      this.uploadsBooks}
    );


  final int? id;
  final String? username;
  final String? avatar;
  final String? email;
  final DateTime? dateJoined;
  final List<String>? userPermissions;
  final List<Livre>? likedBooks;
  final List<Livre>? downloadsBooks;
  final List<Livre>? uploadsBooks;



  factory User.fromJson(String string) => User.fromMap(json.decode(string));

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    username: json['username'] ?? "",
    avatar: json['get_avatar_url'] ?? "",
    email: json['email'] ?? "",
    dateJoined: json['date_joined'] == null ? null: DateTime.parse(json['date_joined']),
    userPermissions: json['user_permissions'] == null ? [] : List<String>.from(json['user_permissions'].map((e) => e)),
    likedBooks: json['get_liked_books'] == null ? [] : List<Livre>.from(json['get_liked_books'].map((e) => Livre.fromMap(e))),
    downloadsBooks: json['get_downloads_books'] == null ? [] : List<Livre>.from(json['get_downloads_books'].map((e) => Livre.fromMap(e))),
    uploadsBooks: json['get_uploads_books'] == null ? [] : List<Livre>.from(json['get_uploads_books'].map((e) => Livre.fromMap(e))),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'avatar': avatar,
    'email': email,
    'dateJoined': dateJoined == null ? DateTime.now().toIso8601String() : dateJoined!.toIso8601String(),
    'userPermissions': userPermissions,
    'likedBooks': likedBooks,
    'downloadsBooks': downloadsBooks,
    'uploadsBooks': uploadsBooks
  };

  String toJson() => json.encode(toMap());
}
