import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/data/models/store_product_model.dart';
import 'package:amici/app/data/services/store_service.dart';

class CategoryController extends GetxController {
  final String categoryName;
  
  // State
  final isLoading = false.obs;
  final products = <StoreProductModel>[].obs;
  final error = ''.obs;
  
  // Filter and sort
  final selectedSort = 'Price: Low to High'.obs;
  final selectedFilters = <String, dynamic>{}.obs;

  CategoryController({required this.categoryName});
  final List<String> sortOptions = [
    'Price: Low to High',
    'Price: High to Low',
  ];
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
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

    products.assignAll(sortedList);
  }
  void navigateToProductDetail(StoreProductModel product) {
    Get.toNamed('/product_detail', arguments: product);
  }

  // Fetch products by category
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      error('');
      
      // Fetch products from the service
      final fetchedProducts = await StoreService.getProductsByCategory(categoryName);
      
      // Apply any existing filters/sort
      products.assignAll(fetchedProducts);
    } catch (e) {
      error('Failed to load products: $e');
      Get.snackbar('Error', 'Failed to load products',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
  
  // Apply filters and sort to products


  

  
  // Refresh products with current filters and sort
  void refreshProducts() {
    final currentProducts = List<StoreProductModel>.from(products);
    products.assignAll(currentProducts);


  }
}
