// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/models/response_data_model.dart/user_data.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';
import 'package:bstore/services/remote_service/user/user_service_impl.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as client;
import 'package:path_provider/path_provider.dart' as p;

class ProfilScreenController extends GetxController {
  LoadingStatus recentBookStatus = LoadingStatus.initial;
  LoadingStatus userStatus = LoadingStatus.initial;
  LoadingStatus downloadStatus = LoadingStatus.initial;

  final LivreService _serviceLivre = LivreServiceImpl();
  final UserService _userService = UserServiceImpl();

  List<Livre> listLivre = <Livre>[];
  List<Livre> downloadsBooks = <Livre>[];
  List<Livre> likedBooks = <Livre>[];
  List<Livre> uploadsBooks = <Livre>[];

  User user = User();
  Livre? selectedToDownload;

  String? progress;
  client.Dio? dio;

  @override
  void onInit() async {
    dio = client.Dio();
    update();
    await getUserData();
    super.onInit();
  }

  Future<List<Directory>?> _getExternalstoragePath() {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.downloads);
  }

  Future downloadAndSaveFileToStorage(Livre livre) async {
    selectedToDownload = livre;
    downloadStatus = LoadingStatus.searching;
    update();
    try {
      final dirList = await _getExternalstoragePath();
      final path = dirList![0].path;
      final file = File(
          "$path/${livre.titre!.toString().capitalizeFirst}.${livre.extension}");
      await dio!.download(livre.fichier.toString(), file.path,
          onReceiveProgress: (rec, total) {
        progress = "${((rec / total) * 100).toStringAsFixed(0)} %";
        // print("Progress : $progress");
      });
      await downloadBook();
      // print(file.path);
    } catch (e) {
      print(e);
      downloadStatus = LoadingStatus.failed;
    }
    update();
  }

  Future downloadBook() async {
    await _serviceLivre.downloadBook(
      idLivre: selectedToDownload!.id!,
      onSuccess: (data) async {
        await getBookById(selectedToDownload!.id!);
      },
      onError: (error) {
        print("======================= Dashbord / Détail error =====================");
        print(error.response!.statusCode);
        print("==========================================================");
        downloadStatus = LoadingStatus.failed;
        update();
      },
    );
  }

  Future getBookById(int id) async {
    update();
    await _serviceLivre.getBookById(
        idLivre: id,
        onSuccess: (data) {
          downloadsBooks = [data.results, ...downloadsBooks];
          downloadStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("======================= Détail error =====================");
          print(error.response!.statusCode);
          print("==========================================================");
          downloadStatus = LoadingStatus.failed;
          update();
        });
  }

  Future getUserData() async {
    userStatus = LoadingStatus.searching;
    update();
    await _userService.getUser(onSuccess: (data) async {
      user = data.results!;
      downloadsBooks = user.downloadsBooks!;
      likedBooks = user.likedBooks!;
      uploadsBooks = user.uploadsBooks!;
      userStatus = LoadingStatus.completed;
      update();
    }, onError: (error) {
      print("================== login / info =================");
      print(error);
      print("=================================================");
      userStatus = LoadingStatus.failed;
    });
  }

  Future getBookForUser() async {
    recentBookStatus = LoadingStatus.searching;
    await _serviceLivre.getBookForUser(onSuccess: (data) {
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
    });
  }

  Future likeBook(int id, int index, String libelle) async {
    await _serviceLivre.likeBook(
        idLivre: id,
        onSuccess: (data) {
          switch (libelle) {
            case 'like':
              likedBooks.removeAt(index);
              break;
            case 'upload':
              uploadsBooks[index] = Livre.fromMap(data['results']);
              if (data['is_like']){
                likedBooks = [ Livre.fromMap(data['results']), ...likedBooks ];
              }
              else{
                likedBooks.removeWhere((e) => e.id == id);
               }
              break;
            case 'download':
              downloadsBooks[index] = Livre.fromMap(data['results']);
              if (data['is_like']){
                likedBooks = [ Livre.fromMap(data['results']), ...likedBooks ];
              }
              else{
                likedBooks.removeWhere((e) => e.id == id);
               }
              break;
            default:
              break;
          }
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
