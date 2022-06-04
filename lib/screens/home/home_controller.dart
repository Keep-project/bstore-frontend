



// ignore_for_file: avoid_print

import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{

  final LivreService  _serviceLivre = LivreServiceImpl();

  List<Livre> listLivre = <Livre>[];

  @override
  void onInit() async{
    await listBooks();
    super.onInit();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  Future listBooks() async {
    await _serviceLivre.listBooks(
      onSuccess:(data){
        listLivre = data.results!;
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error);
        print("==========================================");
      }
    );

  }


}