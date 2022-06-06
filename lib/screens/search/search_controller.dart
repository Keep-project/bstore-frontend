// ignore_for_file: avoid_print

import 'package:bstore/core/app_state.dart';
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

  int _count = 0;
  var next, previous;

  final scrollController = ScrollController();

  @override
  void onInit() async {
    idPage = Get.arguments['id'];
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
