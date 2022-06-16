// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables


import 'dart:io';
import 'package:bstore/services/remote_service/livre/livre_service.dart';
import 'package:bstore/services/remote_service/livre/livre_service_impl.dart';
import 'package:dio/dio.dart' as client;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class BookFormScreenController extends GetxController {

  final LivreService _livreService = LivreServiceImpl();

  final TextEditingController textEditingTitre = TextEditingController();
  final TextEditingController textEditingDescription = TextEditingController();
  final TextEditingController textEditingNombrePage = TextEditingController();
  final TextEditingController textEditingAuteur = TextEditingController();
  final TextEditingController textEditingEditeur = TextEditingController();
  final TextEditingController textEditingLangue = TextEditingController();

  String selectedCategory = "Histoire";
  String selectedLanguage = "Français";

  DateTime datePub = DateTime.now();
  String datePubToString = '09/05/2007';

  final picker = ImagePicker();
  var imageFile;
  String photo = "";

  PlatformFile? _file;
  // final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  List<Map<String, dynamic>> categories = [
    {"id": 1, "libelle": "Histoire"},
    {"id": 2, "libelle": "Geographie"},
    {"id": 3, "libelle": "Psychologie"},
  ];

  List<Map<String, dynamic>> langues = [
    {"id": 1, "libelle": "Français"},
    {"id": 2, "libelle": "Anglais"},
  ];

  void onChangeCategory(dynamic data) {
    selectedCategory = data;
    update();
  }

  void onChangeLanguage(dynamic data) {
    selectedLanguage = data;
    update();
  }

  @override
  void dispose() {
    textEditingTitre.dispose();
    textEditingDescription.dispose();
    textEditingNombrePage.dispose();
    textEditingAuteur.dispose();
    textEditingEditeur.dispose();
    textEditingLangue.dispose();
    super.dispose();
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
      update();
    }
  }

  Future getFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "docx", "pptx"]
    );
    if (result != null) {
      final file = result.files.first;
      _file = file;
      print("Name : ${file.name}");
      print("Bytes : ${file.bytes}");
      print("Size : ${file.size}");
      print("Extension : ${file.extension}");
      print("Path: ${file.path}");
      print("Base name: ${basename(file.path!)}");

    }
  }


  Future saveBook() async {

    client.FormData formData = client.FormData.fromMap({

      "titre": textEditingTitre.text.trim(),
      "description": textEditingDescription.text.trim(),
      "nbpages": int.parse(textEditingNombrePage.text.trim()),
      "langue": selectedLanguage,
      "image": await client.MultipartFile.fromFile(imageFile.path, filename: basename(imageFile.path)),
      "auteur": textEditingAuteur.text.trim(),
      "editeur": textEditingEditeur.text.trim(),
      "categorie": 1,
      "extension": _file!.extension,
      "fichier": await client.MultipartFile.fromFile(_file!.path!, filename: basename(_file!.path!)),
      "datepub": datePub.toIso8601String()

    });


    await _livreService.saveBook(
      livreModel: formData,
      onSuccess: (data){
        print("================= Success =====================");
        print(data);
        print("================================================");
      },
      onError: (error){
        print("================= Error =====================");
        print(error.response!.statusCode);
        if (error.response!.statusCode == 401){
          Get.snackbar(
          "Error", "Votre token est invalide",
        );
        }
        print("================================================");
      }
    );

  }
}
