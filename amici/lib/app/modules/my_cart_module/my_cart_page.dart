import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/my_cart_module/my_cart_controller.dart';
import 'package:amici/app/helper_widgets/cart_widgets.dart';

class MyCartPage extends StatelessWidget {
  MyCartPage({super.key});

  final MyCartController controller = Get.find<MyCartController>();

  @override
  Widget build(BuildContext context) {
    controller.loadCartItems();
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
              child: RefreshIndicator(
                onRefresh: () async {
                  // Refresh cart data
                  await controller.loadCartItems();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cart Header
                        Row(
                          children: [
                            Text(
                              'Cart Items',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Spacer(),
                            Obx(() => Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${controller.totalItems} ${controller.totalItems == 1 ? 'item' : 'items'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                          ],
                        ),

                        SizedBox(height: 12),

                        // Cart Items
                        Obx(() => ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = controller.cartItems[index];
                            return CartItemCard(
                              key: ValueKey(item.id),
                              item: item,
                              onRemove: () => controller.removeItem(item.id),
                              onQuantityChanged: (newQuantity) =>
                                  controller.updateQuantity(item.id, newQuantity),
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Cart Summary
            Obx(() => CartSummaryWidget(
              subtotal: controller.cartTotal.value,
              originalTotal: controller.originalTotal.value,
              totalSavings: controller.totalSavings.value,
              shippingCost: controller.shippingCost.value,
              finalTotal: controller.finalTotal.value,
              hasFreeShipping: controller.hasFreeShipping.value,
              onCheckout: controller.proceedToCheckout,
            )),
          ],
        );
      }),
    );
  }
}