abstract class LivreService {
  Future<void> saveBook({
    dynamic livreModel,
    Function(dynamic data)? onSuccess,
    Function(dynamic data)? onError,
  });

  Future<void> updateBook({
    dynamic livreModel,
    int? idLivre,
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

  Future sendComment({
    int? idLivre,
    String? content,
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
  Future getSimilarBooks({
    String? query,
    String? author,
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
