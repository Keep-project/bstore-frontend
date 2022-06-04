// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

class LivreRequestModel {
  LivreRequestModel({this.fichier,
    this.titre,
    this.description,
    this.nbPages,
    this.langue,
    this.auteur,
    this.editeur,
    this.image,
    this.categorie,
    this.date_pub, 
  });

  final String? titre;
  final String? description;
  final int? nbPages;
  final String? langue;
  final String? auteur;
  final String? editeur;
  File? image;
  final dynamic fichier;
  final int? categorie;
  final String? date_pub;



  Map<String, dynamic> toMap() => {
        'titre': titre ?? '',
        'description': description ?? '',
        'nbPages': nbPages ?? 0,
        'langue': langue ?? '',
        'auteur': auteur ?? '',
        'editeur': editeur ?? '',
        'image': image,
        'fichier': fichier,
        'categorie': categorie ?? 0,
        'date_pub': date_pub,
      };

      String toJson() => json.encode(toMap());
}
