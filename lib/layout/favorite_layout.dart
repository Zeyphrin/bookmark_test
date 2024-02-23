import 'dart:io';

import 'package:bookmark_test/common/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookmark_test/controller/api_controller.dart';
import 'package:bookmark_test/controller/favorite_controller.dart';
import 'package:bookmark_test/model/favorite_model.dart';

class FavoriteLayout extends StatelessWidget {
  const FavoriteLayout({Key? key, required this.favoriteController})
      : super(key: key);

  final FavoriteController favoriteController;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final itemWidth = (screenSize.width - 30) / 2;
    final allPadding = EdgeInsets.all(10.0);
    final ProductController apiController = Get.put(ProductController());

    return Obx(() {


      if (apiController.isOffline.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                size: 72,
              ),
              SizedBox(height: 20),
              Text(
                'Uh Oh No internet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        );
      }
      return Padding(padding: allPadding,
      child: apiController.productList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: itemWidth / (itemWidth + 100),
              ),
              itemCount: favoriteController.favorites.length,
              itemBuilder: (context, index) {
                final product = apiController.productList[index];
                final data = favoriteController.favorites[index];
                return GestureDetector(
                  onTap: () {
                    // Implementasi ketika item di tap
                  },
                  child: Card(
                    color: AppColor.colorWhite,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(data.image),
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              child: Text(
                                data.title,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  color: AppColor.textColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              child: Text(
                                '\$${data.price}',
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  color: AppColor.textColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Obx(
                              () => IconButton(
                                onPressed: () {
                                  AlertDialog alert = AlertDialog(
                                                backgroundColor: Colors.white,
                                                // Set background color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16.0),
                                                ),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.all(16.0),
                                                      child: Text(
                                                        "Are you sure to remove this product from your favorite list?",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            favoriteController.removeFavorite(data);
                                                            Get.back();
                                                          },
                                                          child: const Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                              color: Colors.pinkAccent,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                },
                                icon: Icon(
                                  favoriteController
                                          .checkFavorite(data.id)
                                          .value
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_outline_rounded,
                                  size: 20,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
            );
    });
  }
}
