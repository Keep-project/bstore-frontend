class CategorieRequestMode{
 CategorieRequestMode({this.libelle});

 final String ? libelle;

 Map<String, String> toMap() => {
   'libelle':libelle ?? '',
 };
}