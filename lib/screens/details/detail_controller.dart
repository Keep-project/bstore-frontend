// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bstore/core/app_colors.dart';
import 'package:bstore/core/app_snackbar.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/core/app_user.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:dio/dio.dart' as client;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as p;
//import 'package:permission_handler/permission_handler.dart';

class DetailScreenController extends GetxController {
  LoadingStatus loadingStatus = LoadingStatus.initial;
  LoadingStatus downloadStatus = LoadingStatus.initial;
  LoadingStatus similarStatus = LoadingStatus.initial;
  final LivreService _serviceLivre = LivreServiceImpl();
  final LocalAuthenticationServices _localAuth =
      LocalAuthenticationServicesImpl();

  Livre livre = Livre();
  List<Livre> livresimilaires = <Livre>[];

  final PageController pageController = PageController();
  final TextEditingController commentTextController = TextEditingController();

  int currentIndexPage = 0;
  bool showComments = false;
  List<Text> comments = <Text>[];
  String avatar = "";
  bool is_like = false;

  String? progress;
  client.Dio? dio;
  int bookId = 0;

  @override
  void onInit() async {
    dio = client.Dio();
    await getBookById(Get.arguments);
    await getUserData();
    update();
    super.onInit();
  }

  Future getSimilarBooks() async {
    similarStatus = LoadingStatus.searching;
    await _serviceLivre.getSimilarBooks(
        query: livre.categorie!,
        author: livre.auteur!,
        onSuccess: (data) {
          // On ajout dans la liste des livres similaires en excluant le livre courant
          livresimilaires = data.results!;
          livresimilaires.removeWhere((x) => x.id == livre.id);
          similarStatus = LoadingStatus.completed;
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
          similarStatus = LoadingStatus.failed;
          update();
        });
  }

  Future getUserData() async {
    Map<String, dynamic> userJson = await UserInfo.user();
    if (userJson['avatar'] != "") {
      avatar = userJson['avatar'];
      update();
    }
  }

  Future likeBook(int? index) async {
    await _serviceLivre.likeBook(
        idLivre: index != -1 ? livresimilaires[index!].id! : livre.id!,
        onSuccess: (data) {
          if (index! == -1) {
            is_like = data['is_like'];
            livre = Livre.fromMap(data['results']);
          } else {
            livresimilaires[index] = Livre.fromMap(data['results']);
          }
          update();
        },
        onError: (error) {
          print("=============== Home error ================");
          print(error);
          print("==========================================");
        });
  }

  Future downloadBook() async {
    downloadStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.downloadBook(
      idLivre: livre.id!,
      onSuccess: (data) {
        livre.telecharges = livre.telecharges! + 1;
        downloadStatus = LoadingStatus.completed;
        Future.delayed(const Duration(seconds: 1), (){
          update();
        });
      },
      onError: (error) {
        print("======================= Détail error =====================");
        print(error.response!.statusCode);
        print("==========================================================");
        downloadStatus = LoadingStatus.failed;
        update();
      },
    );
  }

  Future getBookById(int id) async {
    loadingStatus = LoadingStatus.searching;
    update();
    await _serviceLivre.getBookById(
        idLivre: id,
        onSuccess: (data) async {
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
          update();
          await getSimilarBooks();
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
        // print("Progress : $progress");
      });
      await downloadBook();
      //await saveFile(livre.fichier!, "monpdf.pdf");
      // print(file.path);
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

  void saveBookId(int id) async {
    await _localAuth.saveBookId(id.toString());
  }

  Future sendComment(BuildContext context) async {
    if ( commentTextController.text.trim().length < 5 ) {
       CustomSnacbar.showMessage(context, "Votre commentaire est trop court !");
      return;
    }
    await _serviceLivre.sendComment(
      idLivre: livre.id!,
      content: commentTextController.text.trim(),
      onSuccess: (data){
        comments = [ Text(
              data['results']['contenu'],
              style: TextStyle(
                color: kDarkColor86.withOpacity(0.7),
                fontSize: 15,
                height: 1.5,
              ),
            ),  ...comments];
        CustomSnacbar.showMessage(context, data['message']);
        showComments = !showComments;
        update();
      },
      onError: (error) {
        print("================ Comment / error ===================");
        CustomSnacbar.showMessage(context, error.response!.data);
        print(error);
        print("====================================================");
        update();

      }
    );
  }


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Future<String> getFilePath() async {
//     Directory appDocumentsDirectory = await p.getApplicationDocumentsDirectory(); // 1
//     String appDocumentsPath = appDocumentsDirectory.path; // 2
//     String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3
//     print("C'est ici");
//     print(filePath);
//     return filePath;
// }

// Future saveFiles() async {
//     File file = File(await getFilePath()); // 1
//     file.writeAsString("This is my demo text that will be saved to : demoTextFile.txt"); // 2
//   }

// Future readFile() async {
//     File file = File(await getFilePath()); // 1
//     String fileContent = await file.readAsString(); // 2

//     print('File Content: $fileContent');
// }

/////////////////////////////////////////////////////////////////////

  // Future checkPer() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   bool checkResult = await SimplePermissions.checkPermission(
  //       Permission.WriteExternalStorage);
  //   if (!checkResult) {
  //     var status = await SimplePermissions.requestPermission(
  //         Permission.WriteExternalStorage);
  //     //print("permission request result is " + resReq.toString());
  //     if (status == PermissionStatus.authorized) {
  //       await downloadFile(livre.fichier!, "${livre.titre!.toString().capitalizeFirst}.${livre.extension}");
  //     }
  //   } else {
  //     await downloadFile(livre.fichier!, "${livre.titre!.toString().capitalizeFirst}.${livre.extension}");
  //   }
  // }

  Future<void> downloadFile(String url, String fileName) async {
 

    var dir = await p.getExternalStorageDirectory();
    var knockDir =
    await Directory('/storage/Bookstore').create(recursive: true);
    print('NEW DIRECTORY');
    print(knockDir.path);
    await dio!.download(url, '${knockDir.path}/$fileName',
      onReceiveProgress: (rec, total) {
          print("Rec: $rec , Total: $total");
    });
    
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  
  // Future<bool> saveFile(String url, String filename) async {
  //   Directory? directory; 

  //   try {
  //     if (Platform.isAndroid) {
  //       if ( await _requestPermission(Permission.storage)) {
  //         directory = await p.getExternalStorageDirectory();
  //         print(directory!.path);
  //         return true;
  //       }
  //       else {
  //         return false;
  //       }

  //     }
  //     return false;
  //   }
  //   catch (e) {
  //     print(e);
  //     return false;
  //   }
    
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   }
  //   else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //     else {
  //       return false;
  //     }
  //   }
  // }

}
