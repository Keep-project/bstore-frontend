// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:bstore/models/response_data_model.dart/livre_detail_model.dart';

class LivreResponseModel {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<Livre>? results;

  LivreResponseModel({this.count, this.next, this.previous, this.results});

  factory LivreResponseModel.fromJson(String string) =>
      LivreResponseModel.fromMap(json.decode(string));

  factory LivreResponseModel.fromMap(Map<String, dynamic> json) =>
      LivreResponseModel(
        count: json['count'] ?? 0,
        next: json['next'],
        previous: json['previous'],
        results: json['results'] == null
            ? []
            : List<Livre>.from(
                json['results'].map((item) => Livre.fromMap(item))),
      );

  Map<String, dynamic> toMap() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results,
      };

  String toJson() => json.encode(toMap());
}

class Livre {
  final int? id;
  final String? titre;
  final int? proprietaire;
  final String? description;
  final int? nbpages;
  final int? likes;
  int? telecharges;
  final int? nbcommentaires;
  final List<Commentaire>? commentaires;
  final String? image;
  final String? extension;
  final String? fichier;
  final String? langue;
  final String? auteur;
  final String? editeur;
  final DateTime? datepub;
  final DateTime? created_at;
  final DateTime? updated_at;
  bool? is_like;

  Livre({ 
      this.id,
      this.titre,
      this.proprietaire,
      this.description,
      this.nbpages,
      this.likes,
      this.telecharges,
      this.nbcommentaires,
      this.commentaires,
      this.image,
      this.extension,
      this.fichier,
      this.langue,
      this.auteur,
      this.editeur,
      this.datepub,
      this.created_at,
      this.updated_at,
      this.is_like
    });

  factory Livre.fromJson(String string) => Livre.fromMap(json.decode(string));
  factory Livre.fromMap(Map<String, dynamic> json) => Livre(
        id: json['id'] ?? 0,
        titre: json['titre'] ?? "",
        proprietaire: json['proprietaire'] ?? 0,
        description: json['description'] ?? "",
        nbpages: json['nbpages'] ?? 0,
        likes: json['likes']?? 0,
        telecharges: json['telecharges']?? 0,
        nbcommentaires: json['nbcommentaires']?? 0,
        commentaires: json['commentaires'] == null ? [] : List<Commentaire>.from(json['commentaires'].map((x) => Commentaire.fromMap(x))),
        image: json['get_image_url'] ?? "",
        extension: json['extension'] ?? "pdf",
        fichier: json['get_fichier_url'] ?? "",
        langue: json['langue'] ?? "",
        auteur: json['auteur'] ?? "",
        editeur: json['editeur'] ?? "",
        datepub: DateTime.parse(json['datepub']),
        created_at: DateTime.parse(json['created_at']),
        updated_at: DateTime.parse(json['updated_at']),
        is_like: json['is_like'] ?? false,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'titre': titre,
    'proprietaire': proprietaire,
    'description': description,
    'nbpages': nbpages,
    'image': image,
    'extension': extension,
    'likes': likes,
    'telecharges': telecharges,
    'nbcommentaires': nbcommentaires,
    'commentaires': commentaires,
    "fichier": fichier,
    'langue': langue,
    'auteur': auteur,
    'editeur': editeur,
    'datepub': datepub!.toIso8601String(),
    'created_at': created_at!.toIso8601String(),
    'updated_at': updated_at!.toIso8601String(),
    'is_like': is_like
  };

  String toJson() => json.encode(toMap());

}
