import 'dart:convert';

import 'package:bstore/models/response_data_model.dart/livre_model.dart';

class UserRquestModel {
  final bool? success;
  final String? message;
  final List<User>? results;

  UserRquestModel({this.success, this.message, this.results});
}

class User {
  final int? id;
  final String? username;
  final String? avatar;
  final String? email;
  final DateTime? dateJoined;
  final List<String>? userPermissions;
  final List<Livre>? likedBooks;
  final List<Livre>? downloadsBooks;
  final List<Livre>? uploadsBooks;

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


  factory User.fromJson(String string) => User.fromMap(json.decode(string));

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    username: json['username'] ?? "",
    avatar: json['avatar'] ?? "",
    email: json['email'] ?? "",
    dateJoined: json['date_joined'] == null ? null: DateTime.parse(json['dateJoined']),
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
    'dateJoined': dateJoined!.toIso8601String(),
    'userPermissions': userPermissions,
    'likedBooks': likedBooks,
    'downloadsBooks': downloadsBooks,
    'uploadsBooks': uploadsBooks
  };

  String toJson() => json.encode(toMap());
}
