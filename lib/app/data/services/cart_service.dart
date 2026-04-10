import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/cart_item_model.dart';
import '../models/store_product_model.dart';

class CartService extends GetxService {
  static CartService get to => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _cartCollection =>
      _firestore.collection('users').doc(_auth.currentUser?.uid).collection('cart');

  /// Get all cart items as a stream
  /// Get all cart items as a stream
  Stream<List<CartItemModel>> getCartItemsStream() {
    final userId = _auth.currentUser?.uid;
    print('🛒 getCartItemsStream called for user: $userId');

    if (userId == null) {
      print('❌ No user is currently signed in');
      return Stream.value([]); // Return empty stream if no user is signed in
    }

    return _cartCollection.snapshots().asyncMap((snapshot) async {
      print('📦 Fetched ${snapshot.docs.length} cart items from Firestore');
      final items = <CartItemModel>[];

      for (var doc in snapshot.docs) {
        try {
          final data = doc.data();
          print('🔄 Processing cart item: ${doc.id}');

          final productRef = data['product'] as DocumentReference?;
          if (productRef == null) {
            print('⚠️ Product reference is null for cart item: ${doc.id}');
            continue;
          }

          final productDoc = await productRef.get();
          if (!productDoc.exists) {
            print('⚠️ Product document does not exist: ${productRef.path}');
            continue;
          }

          final productData = productDoc.data() as Map<String, dynamic>?;
          if (productData == null) {
            print('⚠️ Product data is null for document: ${productDoc.reference.path}');
            continue;
          }

          final product = StoreProductModel.fromJson({
            'id': productDoc.id,
            ...productData,
          });

          final item = CartItemModel(
            id: doc.id,
            product: product,
            quantity: data['quantity'] as int? ?? 1,
            selectedSize: data['selectedSize'] as String? ?? '',
          );

          items.add(item);
          print('✅ Successfully added item: ${product.name} (${doc.id})');
        } catch (e) {
          print('❌ Error parsing cart item ${doc.id}: $e');
          print('Stack trace: ${StackTrace.current}');
        }
      }

      print('🛍️  Returning ${items.length} valid cart items');
      return items;
    }).handleError((error) {
      print('🔥 Error in cart stream: $error');
      print('Stack trace: ${StackTrace.current}');
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
          'product': _firestore.doc('products/${item.product.id}'),
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
      return snapshot.docs.fold<int>(0, (sum, doc) => sum + (doc.data()['quantity'] as int? ?? 0));
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
          final productDoc = await (data['product'] as DocumentReference).get();
          final productData = productDoc.data() as Map<String, dynamic>?;
          final price = (productData?['offerPrice'] ?? 0.0).toDouble();
          final quantity = (data['quantity'] as int?) ?? 0;
          total += price * quantity;
        } catch (e) {
          print('Error calculating price for item ${doc.id}: $e');
        }
      }

      return total;
    } catch (e) {
      print('Error getting cart total: $e');
      return 0.0;
    }
  }
}
