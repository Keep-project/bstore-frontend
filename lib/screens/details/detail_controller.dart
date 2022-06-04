// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:dio/dio.dart' as client;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as p;

class DetailScreenController extends GetxController {
  LoadingStatus loadingStatus = LoadingStatus.initial;
  final LivreService _serviceLivre = LivreServiceImpl();

  Livre livre = Livre();

  final PageController pageController = PageController();
  int currentIndexPage = 0;
  bool showComments = false;
  List<Text> comments = <Text>[];

  String? progress;
  client.Dio? dio;

  @override
  void onInit() async {
    dio = client.Dio();
    await getBookById();
    super.onInit();
  }

  Future downloadBook() async {
    await _serviceLivre.downloadBook(
      idLivre: livre.id!,
      onSuccess: (data) {
        livre.telecharges = livre.telecharges! + 1; 
        print(data);
        update();
      },
      onError: (error) {
        print("======================= Détail error =====================");
        print(error.response!.statusCode);
        print("==========================================================");
        update();
      },
    );
  }

  Future getBookById() async {
    loadingStatus = LoadingStatus.searching;
    await _serviceLivre.getBookById(
        idLivre: Get.arguments,
        onSuccess: (data) {
          livre = data.results;
          comments = List<Text>.from(livre.commentaires!.map(
            (e) => Text(
              e.contenu.toString(),
              style: TextStyle(
                color: kDarkColor86.withOpacity(0.7),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ));
          loadingStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("======================= Détail error =====================");
          print(error.response!.statusCode);
          print("==========================================================");
          loadingStatus = LoadingStatus.failed;
          update();
        });
  }

  Future<List<Directory>?> _getExternalstoragePath() {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.downloads);
  }

  Future downloadAndSaveFileToStorage() async {
    loadingStatus = LoadingStatus.searching;
    try {
      final dirList = await _getExternalstoragePath();
      final path = dirList![0].path;
      final file = File(
          "$path/${livre.titre!.toString().capitalizeFirst}.${livre.extension}");
      await dio!.download(livre.fichier!, file.path,
          onReceiveProgress: (rec, total) {
        progress = "${((rec / total) * 100).toStringAsFixed(0)} %";
        print("Progress : $progress");
      });
      downloadBook();
      print(file.path);
    } catch (e) {
      print(e);
      loadingStatus = LoadingStatus.failed;
    }
    loadingStatus = LoadingStatus.completed;
    update();
  }

  void onNextChangedPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

  void onPreviousChangedPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    update();
  }

  void onChangePage(int value) {
    currentIndexPage = value;
    update();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
