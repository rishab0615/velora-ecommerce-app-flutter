import 'package:get/get.dart';

import '../../modules/wishlist_module/wishlist_controller.dart';
import '../mock/dummy_products.dart';
import '../models/category_model.dart';
import '../models/store_product_model.dart';

class StoreService {
  static const Duration _mockDelay = Duration(milliseconds: 120);

  static Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(_mockDelay);
    return List<CategoryModel>.from(DummyProducts.categories);
  }

  static Future<List<StoreProductModel>> getProducts() async {
    await Future.delayed(_mockDelay);
    return _withFavoriteState(_activeProducts());
  }

  static Future<List<StoreProductModel>> getNewArrivals() async {
    await Future.delayed(_mockDelay);

    final products =
        _activeProducts().where((product) => product.isNew).take(10).toList();

    return _withFavoriteState(products);
  }

  static Future<List<StoreProductModel>> getSaleProducts() async {
    await Future.delayed(_mockDelay);

    final products = _activeProducts()
        .where((product) => product.onSale || product.hasDiscount)
        .toList();

    return _withFavoriteState(products);
  }

  static Future<List<StoreProductModel>> getProductsByCategory(
    String categoryName,
  ) async {
    await Future.delayed(_mockDelay);

    final products = _activeProducts()
        .where(
          (product) =>
              product.category.toLowerCase() == categoryName.toLowerCase(),
        )
        .toList();

    return _withFavoriteState(products);
  }

  static Future<List<StoreProductModel>> getProductsByIds(
    List<String> productIds,
  ) async {
    await Future.delayed(_mockDelay);

    final idSet = productIds.toSet();
    final products = _activeProducts()
        .where((product) => idSet.contains(product.id))
        .toList();

    return _withFavoriteState(products);
  }

  static StoreProductModel? getProductById(String productId) {
    try {
      final product = DummyProducts.products.firstWhere(
        (item) => item.id == productId,
      );

      return product.copyWith(isFavorite: isFavorite(product.id));
    } catch (_) {
      return null;
    }
  }

  static Future<List<StoreProductModel>> searchProducts(String query) async {
    final searchQuery = query.trim().toLowerCase();

    if (searchQuery.isEmpty) {
      return [];
    }

    await Future.delayed(_mockDelay);

    final products = _activeProducts().where((product) {
      final searchableText = [
        product.name,
        product.description,
        product.category,
        product.sku,
        ...product.features,
      ].join(' ').toLowerCase();

      return searchableText.contains(searchQuery);
    }).toList();

    return _withFavoriteState(products);
  }

  static bool isFavorite(String productId) {
    try {
      final wishlistController = Get.find<WishlistController>();
      return wishlistController.wishlistItems.any(
        (item) => item.id == productId,
      );
    } catch (_) {
      return false;
    }
  }

  static Future<bool> toggleFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  static List<StoreProductModel> _activeProducts() {
    return DummyProducts.products.where((product) => product.active).toList();
  }

  static List<StoreProductModel> _withFavoriteState(
    List<StoreProductModel> products,
  ) {
    return products
        .map(
          (product) => product.copyWith(
            isFavorite: isFavorite(product.id),
          ),
        )
        .toList();
  }
}
