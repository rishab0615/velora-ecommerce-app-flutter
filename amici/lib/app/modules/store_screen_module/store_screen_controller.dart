import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/store_product_model.dart';
import '../../data/models/category_model.dart';
import '../../data/services/store_service.dart';
import '../../routes/app_pages.dart';

class StoreScreenController extends GetxController {
  // Observable variables for reactive UI
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<StoreProductModel> newArrivals = <StoreProductModel>[].obs;
  final RxList<StoreProductModel> saleProducts = <StoreProductModel>[].obs;
  final RxList<StoreProductModel> preOrderProducts = <StoreProductModel>[].obs;
  final RxList<StoreProductModel> searchResults = <StoreProductModel>[].obs;
  
  // Pre-Order by upcoming months (dummy data)
  final RxList<DateTime> upcomingMonths = <DateTime>[].obs; // e.g., next 3 months
  final RxInt selectedPreOrderMonthIndex = 0.obs;
  final RxMap<String, List<StoreProductModel>> preOrderByMonth = <String, List<StoreProductModel>>{}.obs; // key: yyyy-MM
  
  // Loading states
  final RxBool isLoadingCategories = false.obs;
  final RxBool isLoadingNewArrivals = false.obs;
  final RxBool isLoadingSaleProducts = false.obs;
  final RxBool isLoadingPreOrders = false.obs;
  final RxBool isSearching = false.obs;
  
  // UI state
  final RxInt currentCarouselIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearchActive = false.obs;
  
  // Auto-scroll carousel
  Timer? _carouselTimer;
  final RxBool isAutoScrolling = true.obs;
  late PageController pageController;
  
  // Carousel images
  final List<String> carouselImages = [
    'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=800&h=400&fit=crop',
    'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=800&h=400&fit=crop',
    'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=800&h=400&fit=crop',
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _loadInitialData();
    _startAutoScroll();
  }

  @override
  void onClose() {
    _stopAutoScroll();
    pageController.dispose();
    super.onClose();
  }

  /// Load all initial data for the store screen
  Future<void> _loadInitialData() async {
    await Future.wait([
      loadCategories(),
      loadNewArrivals(),
      loadSaleProducts(),
      loadPreOrderProducts(),
    ]);
    _initUpcomingPreOrderDummy();
  }

  /// Load categories from the service
  Future<void> loadCategories() async {
    try {
      isLoadingCategories.value = true;
      final result = await StoreService.getCategories();
      categories.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load categories: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingCategories.value = false;
    }
  }

  /// Load new arrival products
  Future<void> loadNewArrivals() async {
    try {
      isLoadingNewArrivals.value = true;
      final result = await StoreService.getNewArrivals();
      newArrivals.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load new arrivals: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingNewArrivals.value = false;
    }
  }

  /// Load products on sale
  Future<void> loadSaleProducts() async {
    try {
      isLoadingSaleProducts.value = true;
      final result = await StoreService.getSaleProducts();
      saleProducts.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load sale products: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingSaleProducts.value = false;
    }
  }

  /// Load pre-order products (based on preOrder flag)
  Future<void> loadPreOrderProducts() async {
    try {
      isLoadingPreOrders.value = true;
      final all = await StoreService.getProducts();
      final preOrderItems = all.where((p) => p.isPreOrder).toList();
      preOrderProducts.assignAll(preOrderItems);
      print("There are ${preOrderItems.length} pre-order products");
      for(final a in all){
        print("This is a product ${a.isPreOrder}");
      }
      // Group pre-order items by their available month
      _groupPreOrdersByMonth(preOrderItems);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load pre-order products: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingPreOrders.value = false;
    }
  }
  
  /// Group pre-order items by their available month
  void _groupPreOrdersByMonth(List<StoreProductModel> items) {
    preOrderByMonth.clear();
    
    // Get unique months from available dates
    final months = items
        .where((p) => p.availableDate != null)
        .map((p) => DateTime(p.availableDate!.year, p.availableDate!.month))
        .toSet()
        .toList();
    
    // Sort months chronologically
    months.sort((a, b) => a.compareTo(b));
    
    // Update upcoming months with real pre-order months
    upcomingMonths.assignAll(months);
    
    // Group items by month
    for (final item in items.where((p) => p.availableDate != null)) {
      final monthKey = _monthKey(DateTime(item.availableDate!.year, item.availableDate!.month));
      preOrderByMonth.putIfAbsent(monthKey, () => []).add(item);
    }
    
    // Reset selected month index
    selectedPreOrderMonthIndex.value = 0;
  }

  /// Initialize upcoming months for pre-order products
  void _initUpcomingPreOrderDummy() {
    _groupPreOrdersByMonth(preOrderProducts);
  }

  String _monthKey(DateTime dt) => '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}';

  String _monthName(DateTime dt) {
    const names = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    return names[dt.month - 1];
  }

  /// Exposed getter for currently selected month's pre-order items (dummy)
  List<StoreProductModel> get currentMonthPreOrders {
    if (upcomingMonths.isEmpty) return [];
    final index = selectedPreOrderMonthIndex.value.clamp(0, upcomingMonths.length - 1);
    final key = _monthKey(upcomingMonths[index]);
    return preOrderByMonth[key] ?? [];
  }

  /// Switch selected month tab
  void selectPreOrderMonth(int index) {
    if (index >= 0 && index < upcomingMonths.length) {
      selectedPreOrderMonthIndex.value = index;
    }
  }

  /// Search products based on query
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      isSearchActive.value = false;
      return;
    }

    try {
      isSearching.value = true;
      isSearchActive.value = true;
      searchQuery.value = query;
      
      final result = await StoreService.searchProducts(query);
      searchResults.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search products: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSearching.value = false;
    }
  }

  /// Clear search results
  void clearSearch() {
    searchResults.clear();
    searchQuery.value = '';
    isSearchActive.value = false;
  }

  /// Update carousel index
  void updateCarouselIndex(int index) {
    currentCarouselIndex.value = index;
  }

  /// Start auto-scrolling carousel
  void _startAutoScroll() {
    _carouselTimer?.cancel();
    _carouselTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (isAutoScrolling.value && carouselImages.isNotEmpty) {
        final nextIndex = (currentCarouselIndex.value + 1) % carouselImages.length;
        currentCarouselIndex.value = nextIndex;
        // Animate to the next page
        if (pageController.hasClients) {
          pageController.animateToPage(
            nextIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  /// Stop auto-scrolling carousel
  void _stopAutoScroll() {
    _carouselTimer?.cancel();
    _carouselTimer = null;
  }

  /// Pause auto-scrolling (when user interacts with carousel)
  void pauseAutoScroll() {
    isAutoScrolling.value = false;
  }

  /// Resume auto-scrolling
  void resumeAutoScroll() {
    isAutoScrolling.value = true;
  }

  /// Manually navigate to carousel index
  void goToCarouselIndex(int index) {
    currentCarouselIndex.value = index;
    // Pause auto-scroll briefly when user manually navigates
    pauseAutoScroll();
    Future.delayed(Duration(seconds: 5), () {
      resumeAutoScroll();
    });
  }

  /// Navigate to product detail
  void navigateToProductDetail(StoreProductModel product) {
    Get.toNamed('/product_detail', arguments: product);
  }

  /// Navigate to category products
  void navigateToCategory(CategoryModel category) {
    Get.toNamed(
      Routes.CATEGORY,
      arguments: {'category': category.name},
    );
  }

  /// Toggle favorite status for a product
  Future<void> toggleFavorite(StoreProductModel product) async {
    try {
      final success = await StoreService.toggleFavorite(product.id);
      if (success) {
        // Update the product's favorite status in all lists
        _updateProductFavoriteStatus(product.id, !product.isFavorite);
        
        Get.snackbar(
          product.isFavorite ? 'Removed from favorites' : 'Added to favorites',
          product.name,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update favorite status: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Update product favorite status in all lists
  void _updateProductFavoriteStatus(String productId, bool isFavorite) {
    // Update in new arrivals
    final newArrivalIndex = newArrivals.indexWhere((p) => p.id == productId);
    if (newArrivalIndex != -1) {
      newArrivals[newArrivalIndex] = newArrivals[newArrivalIndex].copyWith(isFavorite: isFavorite);
    }

    // Update in sale products
    final saleProductIndex = saleProducts.indexWhere((p) => p.id == productId);
    if (saleProductIndex != -1) {
      saleProducts[saleProductIndex] = saleProducts[saleProductIndex].copyWith(isFavorite: isFavorite);
    }

    // Update in pre-order products
    final preOrderIndex = preOrderProducts.indexWhere((p) => p.id == productId);
    if (preOrderIndex != -1) {
      preOrderProducts[preOrderIndex] = preOrderProducts[preOrderIndex].copyWith(isFavorite: isFavorite);
    }

    // Update in search results
    final searchResultIndex = searchResults.indexWhere((p) => p.id == productId);
    if (searchResultIndex != -1) {
      searchResults[searchResultIndex] = searchResults[searchResultIndex].copyWith(isFavorite: isFavorite);
    }
  }

  /// Refresh all data
  Future<void> refreshData() async {
    await _loadInitialData();
  }

  /// Get loading state for any operation
  bool get isLoading => isLoadingCategories.value || 
                       isLoadingNewArrivals.value || 
                       isLoadingSaleProducts.value || 
                       isLoadingPreOrders.value || 
                       isSearching.value;
}
