import 'package:bookmark_test/api/product_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  RxBool isLoading = true.obs;
  RxBool isOffline = false.obs;

  @override
  void onInit(){
    super.onInit();
    loadData();
  }

  void loadData() async {
    try{
      final response = await http.get(Uri.parse(
          "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));

      if (response.statusCode == 200) {
        productList.value = productFromJson(response.body);
      } else {
        print("status code : " + response.statusCode.toString());
      }

      isLoading.value = false;

    }catch(e){
      print("error : "+e.toString());
    }
  }

}