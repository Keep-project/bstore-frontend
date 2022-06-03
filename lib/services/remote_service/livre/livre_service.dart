


abstract class LivreService {
  Future<void> saveLivre(
    {dynamic livreModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onError,}
  );

}