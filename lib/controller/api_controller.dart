import 'package:bookmark_test/api/product_response_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  RxList<ProductModelResponse> productList = <ProductModelResponse>[].obs;
  RxBool isLoading = false.obs;
  RxBool isOffline = false.obs;

  @override
  void onInit(){
    super.onInit();
    loadData();
  }

void loadData() async {
  print("load data..");
  isLoading.value = true;
  try {
    final response = await http.get(Uri.parse(
        "https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      print("length : ${productList.length}");
      productList.value = productModelResponseFromJson(response.body);
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