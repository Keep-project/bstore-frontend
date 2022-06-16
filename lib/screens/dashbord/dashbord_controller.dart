// ignore_for_file: avoid_print

import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:get/get.dart';

class ProfilScreenController extends GetxController {
  LoadingStatus recentBookStatus = LoadingStatus.initial;

  final LivreService _serviceLivre = LivreServiceImpl();

  List<Livre> listLivre = <Livre>[];

  @override
  void onInit() async {
    await getBookForUser();
    super.onInit();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future getBookForUser() async {
    recentBookStatus = LoadingStatus.searching;
    await _serviceLivre.getBookForUser(
      onSuccess: (data) {
      listLivre = data.results!;
      if (listLivre.isEmpty) {
        recentBookStatus = LoadingStatus.empty;
      } else {
        recentBookStatus = LoadingStatus.completed;
      }
      update();
    }, onError: (error) {
      print("=============== Home error ================");
      print(error.response!.data);
      print(error.response!.statusCode);
      print("==========================================");
      recentBookStatus = LoadingStatus.failed;
      update();
    }
    
    );
  }

  Future likeBook(int index) async {
    await _serviceLivre.likeBook(
        idLivre: listLivre[index].id!,
        onSuccess: (data) {
          if (data['results']['is_like']) {
            listLivre[index].likes = listLivre[index].likes! + 1;
          } else {
            listLivre[index].likes = listLivre[index].likes! - 1;
          }
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
        });
  }
}
