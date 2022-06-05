
import 'dart:convert';

import 'package:bstore/models/response_data_model.dart/livre_model.dart';

class CategorieResponseModel{
  CategorieResponseModel({this.success, this.status, this.message, this.results});

  final bool? success;
  final int? status;
  final String? message;
  final Category? results;

  factory CategorieResponseModel.fromJson(String string) => CategorieResponseModel.fromMap(json.decode(string));
  factory CategorieResponseModel.fromMap(Map<String, dynamic> json) => CategorieResponseModel(
    success: json['success'] ?? true,
    status: json['status'] ?? 0,
    message: json['message'] ?? '',
    results: json['results'] == null ? null : Category.fromMap(json['results']),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'status': status,
    'message': message,
    'results': results
  };

  String toJson() => json.encode(toMap());
}

class Category{
  Category({this.id, this.libelle, this.livres});

  final int? id;
  final String? libelle;
  final List<Livre>? livres;

  factory Category.fromJson(String string) => Category.fromMap(json.decode(string));

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json['id'] ?? 0,
    libelle: json['libelle'] ?? "",
    livres: json['books'] == null ? [] : List<Livre>.from(json['books'].map((x) => Livre.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'libelle': libelle,
    'livres': livres,
  };

  String toJson() => json.encode(toMap());
}