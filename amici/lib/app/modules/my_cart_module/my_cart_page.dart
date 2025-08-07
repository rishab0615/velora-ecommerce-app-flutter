import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/my_cart_module/my_cart_controller.dart';
import 'package:amici/app/helper_widgets/cart_widgets.dart';

class MyCartPage extends StatelessWidget {
   MyCartPage({super.key});

  MyCartController controller = Get.put(MyCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        }

        if (controller.isCartEmpty) {
          return EmptyCartWidget(
            onContinueShopping: controller.continueShopping,
          );
        }

        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cart Header
                    Row(
                      children: [
                        Text(
                          'Cart Items',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${controller.totalItems} items',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Cart Items
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = controller.cartItems[index];
                          return CartItemCard(
                            item: item,
                            onRemove: () => controller.removeItem(item.id),
                            onQuantityChanged: (newQuantity) => 
                                controller.updateQuantity(item.id, newQuantity),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Cart Summary
            CartSummaryWidget(
              subtotal: controller.cartTotal.value,
              originalTotal: controller.originalTotal.value,
              totalSavings: controller.totalSavings.value,
              shippingCost: controller.shippingCost.value,
              finalTotal: controller.finalTotal.value,
              hasFreeShipping: controller.hasFreeShipping.value,
              onCheckout: controller.proceedToCheckout,
            ),
          ],
        );
      }),
    );
  }
}
