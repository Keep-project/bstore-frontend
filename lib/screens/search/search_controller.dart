// ignore_for_file: avoid_print

import 'package:bstore/core/app_state.dart';
import 'package:bstore/core/app_user.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  LoadingStatus infinityStatus = LoadingStatus.initial;
  LoadingStatus searchStatus = LoadingStatus.initial;
  final LivreService _serviceLivre = LivreServiceImpl();

  final TextEditingController searchTextEditingController =
      TextEditingController();

  List<Livre> listLivre = <Livre>[];
  List<Livre> listLivreCopy = <Livre>[];
  String idPage = "";
  String avatar = "";
  String message = "";

  int _count = 0;
  var next, previous;

  final scrollController = ScrollController();

  @override
  void onInit() async {
    await getUserData();
    idPage = Get.arguments['id'];
    message = Get.arguments['message'];
    switch (idPage) {
      case 'search':
        
        await filterBooksByTitleOrDescription();
        break;

      case 'categorie':
        await filterBooksByCategoryId();
        break;

      default:
        await listBooks();
        break;
    }

    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        if (next != null) {
          infinityStatus = LoadingStatus.searching;
          update();
          Future.delayed(const Duration(seconds: 1), () async {
            await listBooks();
          });
        }
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    searchTextEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

   Future getUserData() async {
    Map<String, dynamic> userJson = await UserInfo.user();
    if (userJson['avatar'] != "") {
      avatar = userJson['avatar'];
      update();
    }
  }

  Future filterBooksByCategoryId() async {
    searchStatus = LoadingStatus.searching;
    await _serviceLivre.getCategoriesById(
        idCategory: Get.arguments['pk'],
        onSuccess: (data) {
          listLivreCopy = listLivre;
          listLivre = data.results!.livres!;
          searchStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
          searchStatus = LoadingStatus.failed;
          update();
        });
  }

  Future filterBooksByTitleOrDescription() async {
    infinityStatus = LoadingStatus.searching;
    await _serviceLivre.filterBooksByTitleOrDescription(
      query: Get.arguments['query'],
      onSuccess: (data) {
        _count = data.count;
          next = data.next;
          previous = data.previous;
          listLivre.addAll(data.results!);
          infinityStatus = LoadingStatus.completed;
      update();
    }, onError: (error) {
      print("=============== Home error ================");
      print(error.response!.data);
      print("==========================================");
      infinityStatus = LoadingStatus.failed;
      update();
    });
  }

   Future filterBooks() async {
    message = 'Résultat pour "${searchTextEditingController.text.trim()}"';
    infinityStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.filterBooksByTitleOrDescription(
      query: searchTextEditingController.text.trim(),
      onSuccess: (data) {
        _count = data.count;
          next = data.next;
          previous = data.previous;
          listLivre = data.results!;
          infinityStatus = LoadingStatus.completed;
      update();
    }, onError: (error) {
      print("=============== Home error ================");
      print(error.response!.data);
      print("==========================================");
      infinityStatus = LoadingStatus.failed;
      update();
    });
  }

  Future listBooks() async {
    await _serviceLivre.listBooks(
        url: next,
        onSuccess: (data) {
          _count = data.count;
          next = data.next;
          previous = data.previous;
          listLivre.addAll(data.results!);
          infinityStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
        });
  }

  Future likeBook(int index) async {
    await _serviceLivre.likeBook(
        idLivre: listLivre[index].id!,
        onSuccess: (data) {
          listLivre[index] = Livre.fromMap(data['results']);
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
          update();
        });
  }
}
