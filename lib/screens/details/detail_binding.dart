

import 'package:bstore/screens/details/detail.dart';
import 'package:get/get.dart';

class DetailScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailScreenController());
  }
}