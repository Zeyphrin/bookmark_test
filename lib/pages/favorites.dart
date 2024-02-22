import 'package:bookmark_test/controller/favorite_controller.dart';
import 'package:bookmark_test/layout/favorite_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:bookmark_test/controller/home_controller.dart';

class FavoritePage extends GetView<FavoriteController>{
  final HomeController layoutController = Get.put(HomeController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Obx(() => layoutController.isMobileLayout.value
          ? FavoriteLayout(favoriteController: controller)
          : FavoriteLayout(favoriteController: controller)),
    );
  }
}