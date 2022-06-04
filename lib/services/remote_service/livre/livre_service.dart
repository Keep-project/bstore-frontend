abstract class LivreService {
  Future<void> saveBook({
    dynamic livreModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onError,
  });

  Future listBooks({
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future getBookById({
    int? idLivre,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future downloadBook({
    int? idLivre,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });
}
