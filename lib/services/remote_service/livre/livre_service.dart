abstract class LivreService {
  Future<void> saveBook({
    dynamic livreModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onError,
  });

  Future listBooks({
    String? url,
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

  Future likeBook({
    int? idLivre,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future categoriesList({
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future getCategoriesById({
    int? idCategory,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future filterBooksByTitleOrDescription({
    String? query,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });

  Future getBookForUser({
    String? query,
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });
  Future getPopularBooks({
    Function(dynamic data)? onSuccess,
    Function(dynamic date)? onError,
  });
}
