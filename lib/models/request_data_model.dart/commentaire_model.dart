
class CommentaireRequestModel{
  CommentaireRequestModel({
    this.book, this.contenu
  });
  final String? book;
  final String? contenu;
  
  Map<String, String> toMap() => {
    'book': book ?? "",
    'contenu': contenu ?? "",
  };
}