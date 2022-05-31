class LivreRequestModel{
  LivreRequestModel({
    this.titre ,
    this.description , 
    this.nbPages , 
    this.langue , 
    this.auteur , 
    this.editeur , 
    this.image , 
    this.categorie , 
  });

  final String ? titre;
  final String ? description;
  final String ? nbPages;
  final String ? langue;
  final String ? auteur;
  final String ? editeur;
  final String ? image;
  final String ? categorie;

  Map<String, String> toMap() => {
    'titre': titre ?? '',
    'description': description ?? '',
    'nbPages': nbPages ?? '',
    'langue': langue ?? '',
    'auteur': auteur ?? '',
    'editeur': editeur ?? '',
    'image': image ?? '',
    'categorie': categorie ?? '',
  };
}