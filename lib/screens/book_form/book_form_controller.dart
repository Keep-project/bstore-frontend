// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables


import 'dart:io';
import 'package:bstore/core/app_snackbar.dart';
import 'package:bstore/core/app_state.dart';
import 'package:bstore/models/response_data_model.dart/livre_model.dart';
import 'package:bstore/router/app_router.dart';
import 'package:bstore/screens/book_form/pages/page_one.dart';
import 'package:bstore/screens/book_form/pages/page_three.dart';
import 'package:bstore/screens/book_form/pages/page_two.dart';
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
  LoadingStatus bookStatus = LoadingStatus.initial;
  final TextEditingController textEditingTitre = TextEditingController();
  final TextEditingController textEditingDescription = TextEditingController();
  final TextEditingController textEditingNombrePage = TextEditingController();
  final TextEditingController textEditingAuteur = TextEditingController();
  final TextEditingController textEditingEditeur = TextEditingController();
  final TextEditingController textEditingLangue = TextEditingController();
  final LivreService  _serviceLivre = LivreServiceImpl();

  final PageController pageController = PageController();

  final List<Widget> pages = const <Widget>[
    FormOneScreen(),
    FormTwoScreen(),
    FormThreeScreen(),
  ];

  String selectedCategory = "Psychologie";

  String selectedLanguage = "Français";

  DateTime datePub = DateTime.now();
  String datePubToString = '09/05/2007';
  int step = 1;

  final picker = ImagePicker();
  var imageFile;
  //String photo = "";
  String document = "";

  PlatformFile? _file;
  // final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

  Livre livre = Livre();
  bool showInputFile = true;
  

  List<Map<String, dynamic>> categories = [
        {
            "id": -1,
            "libelle": "Psychologie"
        },
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
  void onInit() async  {
    await categoriesList();
    if ( Get.arguments != null ) {
      livre = Get.arguments;
      showInputFile = false;

      // step 1:
      textEditingTitre.text = livre.titre!;
      textEditingDescription.text = livre.description!;

      // step 2:
      textEditingNombrePage.text = livre.nbpages!.toString();
      textEditingAuteur.text = livre.auteur!;
      textEditingEditeur.text = livre.editeur!;
    }
    super.onInit();
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

  Future categoriesList() async {
    update();
    await _serviceLivre.categoriesList(
      onSuccess:(data){
        data.map((c) {
           categories.add({
          'id': c['id'],
          'libelle': c['libelle'],
        });
        }).toList();
        selectedCategory = categories.firstWhere((e) => e['id'] > 0)['libelle'];
        categories.removeAt(0);
        update();
      },
      onError:(error){
        print("=============== Home error ================");
        print(error);
        print(error.response!.statusCode);
        print("==========================================");
        update();
      }
    );
  }

  Future chooseImage(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(
      source: source,
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
      document = file.name;
      // print("Name : ${file.name}");
      // print("Bytes : ${file.bytes}");
      // print("Size : ${file.size}");
      // print("Extension : ${file.extension}");
      // print("Path: ${file.path}");
      // print("Base name: ${basename(file.path!)}");
      update();
    }
  }

  Future editBook(BuildContext context) async {
    if ( livre.fichier == null ) {
      CustomSnacbar.showMessage(context, "Veuillez selectionner le document à publier svp");
      return;
    }
    bookStatus = LoadingStatus.searching;
    update();

    client.FormData formData = client.FormData.fromMap({
      "titre": textEditingTitre.text.trim(),
      "description": textEditingDescription.text.trim(),
      "nbpages": int.parse(textEditingNombrePage.text.trim()),
      "langue": selectedLanguage,
      "image": imageFile != null ? await client.MultipartFile.fromFile(imageFile.path, filename: basename(imageFile.path)) : "",
      "auteur": textEditingAuteur.text.trim(),
      "editeur": textEditingEditeur.text.trim(),
      "categorie": selectedCategory == "Psychologie" ? 1 : categories.firstWhere((c) => c['libelle'] == selectedCategory)['id'],
      "datepub": datePubToString,

    });

    await _livreService.updateBook(
      idLivre: livre.id!,
      livreModel: formData,
      onSuccess: (data){
        bookStatus = LoadingStatus.completed;
        CustomSnacbar.showMessage(context, "Mise à jour effectuée avec success",);
        Get.offAndToNamed(AppRoutes.DETAILS, arguments: livre.id!);
        update();
      },
      onError: (error){
        print("================= Error =====================");
        print(error);
        print(error.response!.statusCode);
        if (error.response!.statusCode == 401){
          CustomSnacbar.showMessage(context, "Votre session a expiré. Veuillez vous connecter à nouveau pour continuer");
          Get.offAllNamed(AppRoutes.LOGIN);
        }
        print("================================================");
      }
    );

  }

  Future saveBook(BuildContext context) async {

    if ( _file == null ) {
      CustomSnacbar.showMessage(context, "Veuillez selectionner le document à publier svp");
      return;
    }
    bookStatus = LoadingStatus.searching;
    update();

    int id = categories.firstWhere((c) => c['libelle'] == selectedCategory)['id'];
    print("l'id de la catégorie est : $id");

    client.FormData formData = client.FormData.fromMap({
      "titre": textEditingTitre.text.trim(),
      "description": textEditingDescription.text.trim(),
      "nbpages": int.parse(textEditingNombrePage.text.trim()),
      "langue": selectedLanguage,
      "image": imageFile != null ? await client.MultipartFile.fromFile(imageFile.path, filename: basename(imageFile.path)) : "",
      "auteur": textEditingAuteur.text.trim(),
      "editeur": textEditingEditeur.text.trim(),
      "categorie": selectedCategory == "Psychologie" ? 1 : categories.firstWhere((c) => c['libelle'] == selectedCategory)['id'],
      "extension": _file!.extension,
      "fichier": await client.MultipartFile.fromFile(_file!.path!, filename: basename(_file!.path!)),
      "datepub": datePub.toIso8601String()
    });

    await _livreService.saveBook(
      livreModel: formData,
      onSuccess: (data){
        bookStatus = LoadingStatus.completed;
        CustomSnacbar.showMessage(context, "Vous avez ajouter votre livre avec succès!");
        Get.offNamed(AppRoutes.DASHBORD);
        update();
      },
      onError: (error){
        print("================= Error =====================");
        print(error.response!.statusCode);
        if (error.response!.statusCode == 401){
          CustomSnacbar.showMessage(context, "Votre session a expiré. Veuillez vous connecter à nouveau pour continuer");
        }
        print("================================================");
        bookStatus = LoadingStatus.failed;
        update();
      }
    );
  }

  void jumpToStepTwo(BuildContext context) {
    if (textEditingTitre.text.trim().length  < 5) {
      CustomSnacbar.showMessage(context, "Le titre doit contenir au moins 05 caractères !");
      return;
    }
    if (textEditingDescription.text.trim().length  < 20) {
      CustomSnacbar.showMessage(context, "La description doit contenir au moins 20 caractères !");
      return;
    }
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 2;
    update();
  }

  void jumpToStepThree(BuildContext context) {
    if (textEditingNombrePage.text.trim().isEmpty) {
      CustomSnacbar.showMessage(context, "Veuillez indiquer le nombre de page !");
      return;
    }
    if (textEditingAuteur.text.trim().length  < 5) {
      CustomSnacbar.showMessage(context, "Le nom de l'auteur doit avoir au moins 04 caractères !");
      return;
    }

    if (textEditingEditeur.text.trim().length  < 5) {
      CustomSnacbar.showMessage(context, "Le nom de l'editeur doit avoir au moins 04 caractères !");
      return;
    }
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step = 3;
    update();
  }

  void previousPage() {
    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    step -= 1;
    update();
  }
}
