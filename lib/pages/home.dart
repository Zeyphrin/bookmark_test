import 'package:bookmark_test/common/config.dart';
import 'package:bookmark_test/controller/api_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookmark_test/pages/favorites.dart';

class ProductListPage extends StatelessWidget {
  final productController = Get.put(ProductController());

  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allPadding = EdgeInsets.all(10.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Maybelline Library"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.to(CartPage());
            },
          ),
        ],
      ),
      backgroundColor: AppColor.colorLight,
      body: Obx(() {
        return Padding(
          padding: allPadding,
          child: productController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: productController.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productController.productList[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Column(
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
                                    fontSize: 13),
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
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}
