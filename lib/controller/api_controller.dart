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
  try {
    final response = await http.get(Uri.parse(
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline"));

    if (response.statusCode == 200) {
      productList.value = productFromJson(response.body);
      isOffline.value = false; // Set aplikasi dalam mode online setelah berhasil mendapatkan data.
    } else {
      print("Status code: " + response.statusCode.toString());
      isOffline.value = true; // Set aplikasi dalam mode offline jika gagal mendapatkan data.
    }

    isLoading.value = false;

  } catch(e) {
    isOffline.value = true; // Set aplikasi dalam mode offline jika terjadi kesalahan.
    print("Error: $e"); // Cetak pesan kesalahan.
  }
}


}