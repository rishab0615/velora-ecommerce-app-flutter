import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/services/cart_service.dart';
import '../../routes/app_pages.dart';

class MyCartController extends GetxController {
  // Services
  final CartService _cartService = CartService.to;

  // Observable cart items
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  // Observable totals
  final RxDouble cartTotal = 0.0.obs;
  final RxDouble originalTotal = 0.0.obs;
  final RxDouble totalSavings = 0.0.obs;
  final RxDouble shippingCost = 0.0.obs;
  final RxDouble finalTotal = 0.0.obs;
  final RxInt itemCount = 0.obs;
  final RxBool hasFreeShipping = false.obs;

  // Loading state
  final RxBool isLoading = true.obs;

  // Subscription for cart updates
  late StreamSubscription<List<CartItemModel>> _cartSubscription;

  @override
  void onInit() {
    super.onInit();
    _setupCartListener();
  }

  @override
  void onClose() {
    _cartSubscription.cancel();
    super.onClose();
  }

  /// Setup listener for real-time cart updates
  void _setupCartListener() {
    print('🔄 Setting up cart listener...');
    _cartSubscription = _cartService.getCartItemsStream().listen(
          (items) {
        print('📥 Received ${items.length} cart items');
        cartItems.assignAll(items);
        _calculateTotals();
        isLoading.value = false;
        print('✅ Cart updated successfully');
      },
      onError: (error) {
        print('❌ Error in cart listener: $error');
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to load cart items',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onDone: () {
        print('🎉 Cart stream completed');
      },
    );
  }

  /// Calculate cart totals
  void _calculateTotals() {
    // Calculate subtotal
    double subtotal = cartItems.fold(0.0, (sum, item) {
      return sum + (item.product.offerPrice * item.quantity);
    });

    // Calculate savings (if any)
    double savings = cartItems.fold(0.0, (sum, item) {
      final originalPrice = item.product.price ?? item.product.price;
      return sum + ((originalPrice - item.product.offerPrice) * item.quantity);
    });

    // Calculate shipping (example: free shipping over $50)
    double shipping = subtotal >= 50 ? 0 : 5.99;

    // Update observables
    cartTotal.value = subtotal;
    originalTotal.value = subtotal + savings;
    totalSavings.value = savings;
    shippingCost.value = shipping;
    finalTotal.value = subtotal + shipping;
    itemCount.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
    hasFreeShipping.value = shipping == 0;
  }

  /// Update item quantity
  Future<void> updateQuantity(String itemId, int newQuantity) async {
    try {
      print('🔄 Updating quantity for item $itemId to $newQuantity');

      // Update the local state first for immediate UI update
      final index = cartItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        final updatedItem = cartItems[index].copyWith(quantity: newQuantity);
        cartItems[index] = updatedItem;
        _calculateTotals(); // Recalculate totals with the new quantity
      }

      // Then update in Firestore
      await _cartService.updateQuantity(itemId, newQuantity);

      print('✅ Quantity updated successfully');
    } catch (e) {
      print('❌ Error updating quantity: $e');
      // Revert the local change if the server update fails
      _cartService.getCartItemsStream().first.then((items) {
        cartItems.assignAll(items);
        _calculateTotals();
      });

      Get.snackbar(
        'Error',
        'Failed to update quantity',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  /// Remove item from cart
  Future<void> removeItem(String itemId) async {
    try {
      cartItems.removeWhere((item) => item.id == itemId);
      await _cartService.removeFromCart(itemId);
      Get.snackbar(
        'Removed',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item',
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();
      Get.back();
      // Get.snackbar(
      //   'Cart Cleared',
      //   'All items removed from cart',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 2),
      // );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  /// Add item to cart
  Future<void> addToCart(CartItemModel item) async {
    try {
      await _cartService.addToCart(item);
      Get.snackbar(
        'Success',
        '${item.product.name} added to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add item to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      print("This is he error  $e");
      rethrow;
    }
  }
  /// Proceed to checkout
  void proceedToCheckout() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Empty Cart',
        'Please add items to your cart before checkout',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Navigate to checkout page
    Get.toNamed(Routes.CHECKOUT_PAGE);
  }
  /// Manually refresh cart items
  Future<void> loadCartItems() async {
    try {
      isLoading.value = true;
      // Force refresh by getting the latest cart items
      final items = await _cartService.getCartItemsStream().first;
      cartItems.assignAll(items);
      _calculateTotals();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to refresh cart items',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }  /// Continue shopping
  void continueShopping() {
    Get.offAllNamed(Routes.HOME_SCREEN);
  }

  /// Get formatted price
  String getFormattedPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Check if cart is empty
  bool get isCartEmpty => cartItems.isEmpty;

  /// Get total items count
  int get totalItems => itemCount.value;
}