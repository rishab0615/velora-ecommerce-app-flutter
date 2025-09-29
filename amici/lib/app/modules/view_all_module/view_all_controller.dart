import 'package:get/get.dart';
import 'package:amici/app/data/models/store_product_model.dart';

class ViewAllController extends GetxController {
  var products = <StoreProductModel>[].obs;
  var filteredProducts = <StoreProductModel>[].obs;

  var selectedSort = 'Price: Low to High'.obs;  // Default

  final List<String> sortOptions = [
    'Price: Low to High',
    'Price: High to Low',
  ];

  @override
  void onInit() {
    super.onInit();
    filteredProducts.assignAll(products);
  }

  void setProducts(List<StoreProductModel> initialProducts) {
    products.assignAll(initialProducts);
    filteredProducts.assignAll(initialProducts);
  }

  void sortProducts(String sortType) {
    selectedSort.value = sortType;

    List<StoreProductModel> sortedList = List.from(products);

    switch (sortType) {
      case 'Price: Low to High':
        sortedList.sort((a, b) => a.offerPrice.compareTo(b.offerPrice));
        break;
      case 'Price: High to Low':
        sortedList.sort((a, b) => b.offerPrice.compareTo(a.offerPrice));
        break;
    }

    filteredProducts.assignAll(sortedList);
  }

  void navigateToProductDetail(StoreProductModel product) {
    // Get.toNamed('/product-detail', arguments: product);
  }
}
