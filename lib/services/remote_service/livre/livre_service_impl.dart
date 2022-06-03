import 'package:bstore/core/api_library.dart';
import 'package:bstore/core/constants.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';

class LivreServiceImpl implements LivreService {
  final LocalAuthenticationServices _localAuth = LocalAuthenticationServicesImpl();

  @override
  Future<void> saveLivre(
      {dynamic livreModel,
      Function(dynamic data)? onSuccess,
      Function(dynamic data)? onError}) async {
    ApiRequest(
      url: "${Constants.API_URL}/book/",
      data: livreModel,
      token: await _localAuth.getToken(),
    ).post(onSuccess: (data) {
      onSuccess!(data);
    }, onError: (error) {
      if (error != null) {
        onError!(error);
      }
    });
  }
}
