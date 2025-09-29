import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:amici/app/data/models/store_product_model.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find<WishlistController>();
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _authService = FirebaseAuth.instance;

  final RxList<StoreProductModel> wishlistItems = <StoreProductModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isInitialized = false.obs;

  // Collection references
  String get _usersCollection => 'users';
  String get _productsCollection => 'products';

  // Initialize wishlist for the current user
  Future<void> initialize() async {
    if (_authService.currentUser == null) return;
    
    if (!isInitialized.value) {
      await fetchWishlist();
      isInitialized.value = true;
    }
  }

  // Reset wishlist on logout
  void reset() {
    wishlistItems.clear();
    isInitialized.value = false;
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  // Get user's wishlist
  Future<List<String>> _getWishlistIds() async {
    try {
      final user = _authService.currentUser;
      if (user == null) return [];

      final doc = await _firestore.collection(_usersCollection).doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        final wishlist = data?['wishlist'] as List<dynamic>?;
        return wishlist?.map((e) => e.toString()).toList() ?? [];
      }
      return [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch wishlist');
      return [];
    }
  }

  // Get wishlist products
  Future<void> fetchWishlist() async {
    try {
      isLoading.value = true;
      final wishlistIds = await _getWishlistIds();
      
      if (wishlistIds.isEmpty) {
        wishlistItems.clear();
        return;
      }

      final products = await _firestore
          .collection(_productsCollection)
          .where(FieldPath.documentId, whereIn: wishlistIds)
          .get();

      // Map products and set isFavorite to true for all wishlist items
      final wishlistProducts = products.docs
          .map((doc) => StoreProductModel.fromJson({
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
                'isFavorite': true, // Ensure isFavorite is set to true
              }))
          .toList();

      wishlistItems.assignAll(wishlistProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load wishlist products');
    } finally {
      isLoading.value = false;
    }
  }

  // Add product to wishlist
  // Future<bool> addToWishlist(String productId) async {
  //   try {
  //     final user = _authService.currentUser;
  //     if (user == null) return false;
  //
  //     final userRef = _firestore.collection(_usersCollection).doc(user.uid);
  //
  //     await _firestore.runTransaction((transaction) async {
  //       final doc = await transaction.get(userRef);
  //       if (!doc.exists) {
  //         // Create user document if it doesn't exist
  //         transaction.set(userRef, {
  //           'wishlist': [productId],
  //           'createdAt': FieldValue.serverTimestamp(),
  //         });
  //       } else {
  //         final data = doc.data() as Map<String, dynamic>;
  //         final wishlist = List<String>.from(data['wishlist'] ?? []);
  //
  //         if (!wishlist.contains(productId)) {
  //           wishlist.add(productId);
  //           transaction.update(userRef, {
  //             'wishlist': wishlist,
  //             'updatedAt': FieldValue.serverTimestamp(),
  //           });
  //         }
  //       }
  //     });
  //
  //     // Refresh the wishlist
  //     await fetchWishlist();
  //     return true;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to add to wishlist');
  //     return false;
  //   }
  // }

  // Remove product from wishlist
  // Future<bool> removeFromWishlist(String productId) async {
  //   try {
  //     final user = _authService.currentUser;
  //     if (user == null) return false;
  //
  //     final userRef = _firestore.collection(_usersCollection).doc(user.uid);
  //
  //     await _firestore.runTransaction((transaction) async {
  //       final doc = await transaction.get(userRef);
  //       if (doc.exists) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         final wishlist = List<String>.from(data['wishlist'] ?? []);
  //
  //         if (wishlist.contains(productId)) {
  //           wishlist.remove(productId);
  //           transaction.update(userRef, {
  //             'wishlist': wishlist,
  //             'updatedAt': FieldValue.serverTimestamp(),
  //           });
  //         }
  //       }
  //     });
  //
  //     // Update local list
  //     wishlistItems.removeWhere((item) => item.id == productId);
  //     Get.snackbar('Success', 'Removed from wishlist');
  //     return true;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to remove from wishlist');
  //     return false;
  //   }
  // }

  // Check if product is in wishlist
  Future<bool> isInWishlist(String productId) async {
    try {
      final wishlist = await _getWishlistIds();
      return wishlist.contains(productId);
    } catch (e) {
      return false;
    }
  }
  void navigateToProductDetail(StoreProductModel product) {
    Get.toNamed('/product_detail', arguments: product);
  }
  // Toggle wishlist status
  // Toggle wishlist status with optimistic updates
  Future<bool> toggleWishlist(StoreProductModel product) async {
    try {
      final user = _authService.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'Please sign in to manage your wishlist');
        return false;
      }

      // Optimistically update local state
      final wasInWishlist = wishlistItems.any((item) => item.id == product.id);
      if (wasInWishlist) {
        // Optimistically remove
        wishlistItems.removeWhere((item) => item.id == product.id);
      } else {
        // Optimistically add
        wishlistItems.insert(0, product.copyWith(isFavorite: true));
      }

      // Update in Firestore
      final success = wasInWishlist
          ? await removeFromWishlist(product.id)
          : await addToWishlist(product.id);

      if (!success) {
        // Revert on error
        await fetchWishlist();
        return false;
      }

      return true;
    } catch (e) {
      // Revert on error
      await fetchWishlist();
      return false;
    }
  }

// Private method to handle Firestore removal
  Future<bool> removeFromWishlist(String productId) async {
    try {
      final user = _authService.currentUser!;
      final userRef = _firestore.collection(_usersCollection).doc(user.uid);

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userRef);
        if (doc.exists) {
          final data = doc.data()!;
          final wishlist = List<String>.from(data['wishlist'] ?? []);
          wishlist.remove(productId);
          transaction.update(userRef, {
            'wishlist': wishlist,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }

// Private method to handle Firestore addition
  Future<bool> addToWishlist(String productId) async {
    try {
      final user = _authService.currentUser!;
      final userRef = _firestore.collection(_usersCollection).doc(user.uid);

      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(userRef);
        if (!doc.exists) {
          transaction.set(userRef, {
            'wishlist': [productId],
            'createdAt': FieldValue.serverTimestamp(),
          });
        } else {
          final data = doc.data()!;
          final wishlist = List<String>.from(data['wishlist'] ?? []);
          if (!wishlist.contains(productId)) {
            wishlist.add(productId);
            transaction.update(userRef, {
              'wishlist': wishlist,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          }
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}