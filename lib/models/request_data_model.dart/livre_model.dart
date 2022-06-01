import 'dart:convert';

class LivreRequestModel {
  LivreRequestModel({
    this.titre,
    this.description,
    this.nbPages,
    this.langue,
    this.auteur,
    this.editeur,
    this.image,
    this.categorie,
  });

  final String? titre;
  final String? description;
  final int? nbPages;
  final String? langue;
  final String? auteur;
  final String? editeur;
  final String? image;
  final int? categorie;



  Map<String, dynamic> toMap() => {
        'titre': titre ?? '',
        'description': description ?? '',
        'nbPages': nbPages ?? 0,
        'langue': langue ?? '',
        'auteur': auteur ?? '',
        'editeur': editeur ?? '',
        'image': image ?? '',
        'categorie': categorie ?? 0,
      };

      String toJson() => json.encode(toMap());
}
