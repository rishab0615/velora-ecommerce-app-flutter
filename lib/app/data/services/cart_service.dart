import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import 'store_service.dart';

class CartService extends GetxService {
  static CartService get to => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _cartCollection => _firestore
      .collection('users')
      .doc(_auth.currentUser?.uid)
      .collection('cart');

  /// Get all cart items as a stream
  /// Get all cart items as a stream
  Stream<List<CartItemModel>> getCartItemsStream() {
    final userId = _auth.currentUser?.uid;
    debugPrint('Cart stream requested for user: $userId');

    if (userId == null) {
      debugPrint('No user is currently signed in');
      return Stream.value([]); // Return empty stream if no user is signed in
    }

    return _cartCollection.snapshots().asyncMap((snapshot) async {
      debugPrint('Fetched ${snapshot.docs.length} cart items from Firestore');
      final items = <CartItemModel>[];

      for (var doc in snapshot.docs) {
        try {
          final data = doc.data();
          debugPrint('Processing cart item: ${doc.id}');

          final productId = _readProductId(data);
          if (productId == null) {
            debugPrint('Product id is missing for cart item: ${doc.id}');
            continue;
          }

          final product = StoreService.getProductById(productId);
          if (product == null) {
            debugPrint('Mock product does not exist: $productId');
            continue;
          }

          final item = CartItemModel(
            id: doc.id,
            product: product,
            quantity: data['quantity'] as int? ?? 1,
            selectedSize: data['selectedSize'] as String? ?? '',
          );

          items.add(item);
          debugPrint('Successfully hydrated cart item: ${product.name}');
        } catch (e) {
          debugPrint('Error parsing cart item ${doc.id}: $e');
          debugPrint('Stack trace: ${StackTrace.current}');
        }
      }

      debugPrint('Returning ${items.length} valid cart items');
      return items;
    }).handleError((error) {
      debugPrint('Error in cart stream: $error');
      debugPrint('Stack trace: ${StackTrace.current}');
      return <CartItemModel>[]; // Return empty list on error
    });
  }

  /// Add item to cart or update quantity if exists
  Future<void> addToCart(CartItemModel item) async {
    try {
      final docRef = _cartCollection.doc(item.id);
      final doc = await docRef.get();

      if (doc.exists) {
        // Update quantity if item exists
        await docRef.update({
          'quantity': FieldValue.increment(item.quantity),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Add new item
        await docRef.set({
          'productId': item.product.id,
          'quantity': item.quantity,
          'selectedSize': item.selectedSize,
          'addedAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add item to cart');
      rethrow;
    }
  }

  /// Update item quantity
  Future<void> updateQuantity(String itemId, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        // Remove item if quantity is 0 or negative
        await _cartCollection.doc(itemId).delete();
      } else {
        // Update quantity
        await _cartCollection.doc(itemId).update({
          'quantity': newQuantity,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update item quantity');
      rethrow;
    }
  }

  /// Remove item from cart
  Future<void> removeFromCart(String itemId) async {
    try {
      await _cartCollection.doc(itemId).delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item from cart');
      rethrow;
    }
  }

  /// Clear all items from cart
  Future<void> clearCart() async {
    try {
      final batch = _firestore.batch();
      final snapshot = await _cartCollection.get();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      Get.snackbar('Error', 'Failed to clear cart');
      rethrow;
    }
  }

  /// Get total number of items in cart
  Future<int> getItemCount() async {
    try {
      final snapshot = await _cartCollection.get();
      return snapshot.docs.fold<int>(
        0,
        (total, doc) => total + (doc.data()['quantity'] as int? ?? 0),
      );
    } catch (e) {
      return 0;
    }
  }

  /// Get total cart value
  Future<double> getCartTotal() async {
    try {
      final snapshot = await _cartCollection.get();
      double total = 0.0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        try {
          final productId = _readProductId(data);
          final product =
              productId == null ? null : StoreService.getProductById(productId);
          final quantity = (data['quantity'] as int?) ?? 0;
          total += (product?.offerPrice ?? 0.0) * quantity;
        } catch (e) {
          debugPrint('Error calculating price for item ${doc.id}: $e');
        }
      }

      return total;
    } catch (e) {
      debugPrint('Error getting cart total: $e');
      return 0.0;
    }
  }

  String? _readProductId(Map<String, dynamic> data) {
    final productId = data['productId'] as String?;

    if (productId != null && productId.isNotEmpty) {
      return productId;
    }

    final legacyProductRef = data['product'] as DocumentReference?;
    return legacyProductRef?.id;
  }
}
