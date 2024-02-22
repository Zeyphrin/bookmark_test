import 'package:bookmark_test/db_helper.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
   Database db = DbHelper.getDb();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  } 
}
