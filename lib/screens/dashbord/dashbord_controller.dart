// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:bstore/core/app_snackbar.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/models/response_data_model.dart/user_data.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/services/local_service/authentication/authentication_service.dart';
import 'package:bstore/services/local_service/authentication/authentication_service_impl.dart';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:bstore/services/remote_service/user/user_service.dart';
import 'package:bstore/services/remote_service/user/user_service_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as client;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class ProfilScreenController extends GetxController {
  LoadingStatus recentBookStatus = LoadingStatus.initial;
  LoadingStatus userStatus = LoadingStatus.initial;
  LoadingStatus downloadStatus = LoadingStatus.initial;
  final LocalAuthenticationServices _localAuth =
      LocalAuthenticationServicesImpl();

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

  var imageFile;
  final picker = ImagePicker();

  @override
  void onInit() async {
    dio = client.Dio();
    await getUserData();
    super.onInit();
    update();
  }

  Future deleteToken() async {
    await _localAuth.deleteToken();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Future chooseImage() async {
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      // var imageBytes = imageFile.readAsBytesSync();
      // var encoded = base64Encode(imageBytes);
      // photo = "data:image/png;base64, $encoded";
      await updateUserData();
      update();
    }
  }

  Future updateUserData() async {
    print(imageFile.path);

    client.FormData formData = client.FormData.fromMap({
      "id": user.id!,
      "username": user.username,
      "first_name": "",
      "last_name": "",
      "email": user.email,
      "user_permissions": user.userPermissions,
      "avatar": imageFile != null
          ? await client.MultipartFile.fromFile(imageFile.path,
              filename: basename(imageFile.path))
          : "",
    });

    await _userService.updateUserData(
        userId: user.id!,
        userData: formData,
        onSuccess: (data) async {
          await _localAuth.saveUser(json.encode(data.results!.toMap()));
          await getUserData();
        },
        onError: (error) {
          print("===================== Update date / error =================");
          print(error);
          print("===========================================================");
          update();
        });
  }

  Future downloadAndSaveFileToStorage(BuildContext context, Livre livre) async {
    selectedToDownload = livre;
    downloadStatus = LoadingStatus.searching;
    update();
    try {
      await saveFile(livre.fichier!,
          "${livre.titre!.toString().capitalizeFirst}.${livre.extension}");
      await downloadBook();
      CustomSnacbar.showMessage(context,
          "Document Téléchargé avec succès! ${livre.titre!.toString().capitalizeFirst}.${livre.extension} est desormais disponible dans le dossier de téléchargement de votre téléphone");
    } catch (e) {
      print(e);
      downloadStatus = LoadingStatus.failed;
    }
    update();
  }

  Future<bool> saveFile(String url, String filename) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await p.getExternalStorageDirectory();
          String newPath = "";

          List<String> folders = directory!.path.split("/");

          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          if (await directory.exists()) {
            File file = File("${directory.path}/$filename");
            await dio!.download(url, file.path,
                onReceiveProgress: (rec, total) {
              progress = "${((rec / total) * 100).toStringAsFixed(0)} %";
            });
          }
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future downloadBook() async {
    await _serviceLivre.downloadBook(
      idLivre: selectedToDownload!.id!,
      onSuccess: (data) async {
        await getBookById(selectedToDownload!.id!);
      },
      onError: (error) {
        print(
            "======================= Dashbord / Détail error =====================");
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
              if (data['is_like']) {
                likedBooks = [Livre.fromMap(data['results']), ...likedBooks];
              } else {
                likedBooks.removeWhere((e) => e.id == id);
              }
              break;
            case 'download':
              downloadsBooks[index] = Livre.fromMap(data['results']);
              if (data['is_like']) {
                likedBooks = [Livre.fromMap(data['results']), ...likedBooks];
              } else {
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
