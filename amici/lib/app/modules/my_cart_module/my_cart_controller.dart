import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/services/cart_service.dart';

class MyCartController extends GetxController {
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
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  /// Load cart items and calculate totals
  void loadCartItems() {
    isLoading.value = true;
    
    try {
      final items = CartService.getCartItems();
      cartItems.assignAll(items);
      _calculateTotals();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load cart items: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Calculate all totals
  void _calculateTotals() {
    cartTotal.value = CartService.getCartTotal();
    originalTotal.value = CartService.getCartOriginalTotal();
    totalSavings.value = CartService.getTotalSavings();
    shippingCost.value = CartService.getShippingCost();
    finalTotal.value = CartService.getFinalTotal();
    itemCount.value = CartService.getCartItemCount();
    hasFreeShipping.value = CartService.hasFreeShipping();
  }

  /// Update item quantity
  void updateQuantity(String itemId, int newQuantity) {
    try {
      CartService.updateQuantity(itemId, newQuantity);
      loadCartItems(); // Reload to update UI
      
      if (newQuantity <= 0) {
        Get.snackbar(
          'Removed',
          'Item removed from cart',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update quantity: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Remove item from cart
  void removeItem(String itemId) {
    try {
      CartService.removeFromCart(itemId);
      loadCartItems(); // Reload to update UI
      
      Get.snackbar(
        'Removed',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Clear entire cart
  void clearCart() {
    Get.dialog(
      AlertDialog(
        title: Text('Clear Cart'),
        content: Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              try {
                CartService.clearCart();
                loadCartItems(); // Reload to update UI
                Get.back();
                
                Get.snackbar(
                  'Cart Cleared',
                  'All items removed from cart',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 2),
                );
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Failed to clear cart: ${e.toString()}',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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
    Get.toNamed('/checkout');
  }

  /// Continue shopping
  void continueShopping() {
    Get.back(); // Go back to previous screen
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
