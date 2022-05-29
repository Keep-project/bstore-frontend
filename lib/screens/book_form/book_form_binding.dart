
import 'package:bstore/screens/book_form/book_form.dart';
import 'package:get/get.dart';

class BookFormScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookFormScreenController>(() => BookFormScreenController());
  }
}