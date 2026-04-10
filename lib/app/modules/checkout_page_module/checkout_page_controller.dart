import 'package:amici/app/modules/checkout_page_module/success_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../my_cart_module/my_cart_controller.dart';

class CheckoutPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;

  final MyCartController cartController = Get.find<MyCartController>();

  // Text Controllers
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // Loading state
  final isPlacingOrder = false.obs;

  Future<void> placeOrder() async {
    if (!formKey.currentState!.validate()) return;

    isPlacingOrder(true);

    try {
      final userId =FirebaseAuth.instance.currentUser!.uid;
      final orderData = {
        'userId': userId,
        'phone': phoneController.text.trim(),
        'address': addressController.text.trim(),
        'items': cartController.cartItems.map((item) => {
          'productId': item.product.id,
          'name': item.product.name,
          'price': item.product.offerPrice,
          'quantity': item.quantity,
          'size': item.selectedSize,
        }).toList(),
        'subtotal': cartController.cartTotal.value,
        'shipping': cartController.shippingCost.value,
        'total': cartController.finalTotal.value,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Add order to Firestore
      await _firestore.collection('orders').add(orderData);

      // Clear cart after successful order
      await cartController.clearCart();

      // Navigate to success page
      Get.off(
            () => OrderSuccessPage(),
        arguments: {
          'phone': phoneController.text.trim(),
          'address': addressController.text.trim(),
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to place order: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isPlacingOrder(false);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}