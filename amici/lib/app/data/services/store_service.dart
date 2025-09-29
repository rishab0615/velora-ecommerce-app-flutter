import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/store_product_model.dart';
import '../models/category_model.dart';
import '../../modules/wishlist_module/wishlist_controller.dart';

class StoreService {
  // Helper method to map Firestore document to StoreProductModel
  static StoreProductModel _mapDocumentToProduct(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StoreProductModel(
      id: doc.id,
      name: data['name'] ?? 'No Name',
      description: data['description'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      price: (data['price'] ?? 0.0).toDouble(),
      offerPrice: (data['offerPrice'] ?? 0.0).toDouble(),
      active: data['active'] ?? false,
      onSale: data['onSale'] ?? false,
      category: data['category'] ?? 'Uncategorized',
      features: List<String>.from(data['features'] ?? []),
      sku: data['sku'] ?? '',
      stock: (data['stock'] ?? 0).toInt(),
      rating: (data['rating'] ?? 0.0).toDouble(),
      sizes: List<String>.from(data['sizes'] ?? []),
      isNew: data['isNew'] ?? false,
      isPreOrder: data['isPreOrder'] ?? false,
      availableDate: data['availableDate'] != null
          ? DateTime.tryParse(data['availableDate'] as String)
          : null,
    );
  }

  // Get all categories
  static Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('categories').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel(
          id: data['id'] ?? doc.id,
          name: data['name'] ?? 'No Name',
          imageUrl: data['imageUrl'] ?? '',
          description: '', // Add this field if you want to include it in Firestore
          productCount: 0, // You might want to add this to Firestore or calculate it
        );
      }).toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return []; // Return empty list in case of error
    }
  }

  // Get all products
  static Future<List<StoreProductModel>> getProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .get();
      
      return snapshot.docs.map(_mapDocumentToProduct).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Get 10 most recently added products
  static Future<List<StoreProductModel>> getNewArrivals() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();
      
      return snapshot.docs.map(_mapDocumentToProduct).toList();
    } catch (e) {
      print('Error fetching new arrivals: $e');
      return [];
    }
  }

  // Get products on sale
  static Future<List<StoreProductModel>> getSaleProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .where('onSale', isEqualTo: true)
          .get();
      
      return snapshot.docs.map(_mapDocumentToProduct).toList();
    } catch (e) {
      print('Error fetching sale products: $e');
      return [];
    }
  }

  // Get products by category
  static Future<List<StoreProductModel>> getProductsByCategory(String categoryName) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .where('category', isEqualTo: categoryName)
          .get();
      
      return snapshot.docs.map(_mapDocumentToProduct).toList();
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  // Search products
  static Future<List<StoreProductModel>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final searchQuery = query.toLowerCase();
      
      // First, search in product names
      final nameQuery = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: searchQuery + '\uf8ff')
          .get();
      
      // Then search in descriptions
      final descQuery = await FirebaseFirestore.instance
          .collection('products')
          .where('active', isEqualTo: true)
          .where('description', isGreaterThanOrEqualTo: searchQuery)
          .where('description', isLessThanOrEqualTo: searchQuery + '\uf8ff')
          .get();
      
      // Combine and deduplicate results
      final allDocs = [...nameQuery.docs, ...descQuery.docs];
      final uniqueDocs = allDocs.fold<Map<String, DocumentSnapshot>>({}, (map, doc) {
        map[doc.id] = doc;
        return map;
      });
      
      return uniqueDocs.values.map(_mapDocumentToProduct).toList();
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }

  // Check if product is in wishlist
  static bool isFavorite(String productId) {
    try {
      final wishlistController = Get.find<WishlistController>();
      return wishlistController.wishlistItems.any((item) => item.id == productId);
    } catch (e) {
      return false;
    }
  }

  // Toggle favorite status
  static Future<bool> toggleFavorite(String productId) async {
    await Future.delayed(Duration(milliseconds: 200));

    return true;
  }
} 