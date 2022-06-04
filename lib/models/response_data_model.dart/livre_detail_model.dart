// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:bstore/models/response_data_model.dart/livre_model.dart';

class LivreDetailResponseModel {
  final bool? success;
  final String? message;
  final int? status;
  final Livre? results;

  LivreDetailResponseModel(
      {this.success, this.message, this.status, this.results});

    factory LivreDetailResponseModel.fromJson(String string) => LivreDetailResponseModel.fromMap(json.decode(string));

    factory LivreDetailResponseModel.fromMap(Map<String, dynamic> json) => LivreDetailResponseModel(
      success: json['success'] ?? true,
      message: json['message']?? '',
      status: json['status']?? 0,
      results: json['results'] == null ? null : Livre.fromMap(json['results']),
    );

    Map<String, dynamic> toMap() => {
      'success': success,
      'message': message,
      'status': status,
      'results': results,
    };

    String toJson() => json.encode(toMap());
}

class Commentaire{
  final int? id;
  final int? utilisateur;
  final String? contenu;
  final DateTime? created_at;
  final DateTime? updated_at;

  Commentaire({this.id, this.utilisateur, this.contenu, this.created_at, this.updated_at});

  factory Commentaire.fromJson(String string) => Commentaire.fromMap(json.decode(string));

  factory Commentaire.fromMap(Map<String, dynamic> json) => Commentaire(
    id: json['id'] ?? 0,
    utilisateur: json['utilisateur']?? 0,
    contenu: json['contenu']?? '',
    created_at: DateTime.parse(json['created_at']),
    updated_at: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'utilisateur': utilisateur,
    'contenu': contenu,
    'created_at': created_at!.toIso8601String(),
    'updated_at': updated_at!.toIso8601String(),

  };

  String toJson() => json.encode(toMap());

}



 