import 'package:bookmark_test/common/config.dart';
import 'package:bookmark_test/controller/api_controller.dart';
import 'package:bookmark_test/controller/favorite_controller.dart';
import 'package:bookmark_test/model/favorite_model.dart';
import 'package:bookmark_test/pages/favorites.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final itemWidth = (screenSize.width - 30) / 2;
    final allPadding = EdgeInsets.all(10.0);
    final ProductController apiController = Get.put(ProductController());
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Maybelline Library"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.to(() => FavoritePage());
            },
          ),
        ],
      ),
      backgroundColor: AppColor.colorLight,
      body: Padding(
        padding: allPadding,
        child: Obx(
          () => apiController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: itemWidth / (itemWidth + 100),
                  ),
                  itemCount: apiController.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = apiController.productList[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: AppColor.colorWhite,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    product.imageLink,
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
                                    product.name,
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
                                    '\$${product.price}',
                                    style: TextStyle(
                                      fontFamily: "ProductSans",
                                      color: AppColor.textColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Obx(
                                  () => IconButton(
                                    onPressed: () {
                                      print(
                                          "index: $index | id: ${product.id}");
                                      favoriteController.tapLike(
                                        Favorite(
                                            id: product.id,
                                            title: product.name,
                                            image: product.imageLink,
                                            price: product.price),
                                      );
                                    },
                                    icon: Icon(
                                      favoriteController
                                              .checkFavorite(product.id)
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
                ),
        ),
      ),
    );
  }
}
