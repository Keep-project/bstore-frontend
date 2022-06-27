



// ignore_for_file: avoid_print

import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/category_model.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{
  LoadingStatus recentBookStatus = LoadingStatus.initial;
  LoadingStatus categoriesListStatus = LoadingStatus.initial;
  LoadingStatus popularListStatus = LoadingStatus.initial;

  final TextEditingController searchTextEditingController = TextEditingController();

  final LivreService  _serviceLivre = LivreServiceImpl();

  List<Livre> listLivre = <Livre>[];
  List<Livre> popularLivreBooks = <Livre>[];

  List<Category> listCategories = <Category>[];

  @override
  void onInit() async{
    await categoriesList();
    await listBooks();
    await popularListBooks();
    super.onInit();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  Future popularListBooks() async {
    popularListStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.getPopularBooks(
      onSuccess:(data){
        popularLivreBooks = data.results!;
        popularListStatus = LoadingStatus.completed;
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error.response!.data);
        print(error.response!.statusCode);
        print("==========================================");
        popularListStatus = LoadingStatus.failed;
        update();
      }
    );
  }

  Future listBooks() async {
    
    recentBookStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.listBooks(
      onSuccess:(data){
        listLivre = data.results!;
        recentBookStatus = LoadingStatus.completed;
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error.response!.data);
        print(error.response!.statusCode);
        print("==========================================");
        recentBookStatus = LoadingStatus.failed;
        update();
      }
    );

  }

  Future categoriesList() async {
    categoriesListStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.categoriesList(
      onSuccess:(data){
        listCategories = List<Category>.from(data.map((c) => Category.fromMap(c)));
        
        categoriesListStatus = LoadingStatus.completed;
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error.response!.data);
        print(error.response!.statusCode);
        if (error.response!.statusCode == 401){
          Get.offAndToNamed(AppRoutes.LOGIN);
        }
        print("==========================================");
        categoriesListStatus = LoadingStatus.failed;
        update();
      }
    );
  }

  Future likeBook(int index) async {
  
    await _serviceLivre.likeBook(
      idLivre: listLivre[index].id!,
      onSuccess:(data) async{
        int nb = listLivre[index].nbcommentaires!;
        listLivre[index] = Livre.fromMap(data['results']);
        listLivre[index].nbcommentaires = nb;
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error);
        print("==========================================");
      }
    );
  }

  Future likePopularBook(int index) async {
    await _serviceLivre.likeBook(
      idLivre: popularLivreBooks[index].id!,
      onSuccess:(data){
        popularLivreBooks[index] = Livre.fromMap(data['results']);
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error);
        print("==========================================");
      }
    );
  }

  Future getBookById(int id) async {
    update();
    await _serviceLivre.getBookById(
        idLivre: id,
        onSuccess: (data) {
          // livre = data.results;
          update();
        },
        onError: (error) {
          print("======================= Détail error =====================");
          print(error.response!.statusCode);
          print("==========================================================");
          update();
        });
  }



}