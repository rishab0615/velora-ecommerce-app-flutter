import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/wishlist_module/wishlist_controller.dart';
import 'package:amici/app/theme/app_colors.dart';
import 'package:amici/app/helper_widgets/store_widgets.dart';
import 'package:amici/app/data/models/store_product_model.dart';

import '../../routes/app_pages.dart';

class WishlistPage extends GetView<WishlistController> {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Wishlist',style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.wishlistItems.isEmpty) {
          return _buildEmptyWishlist();
        }

        return _buildWishlistItems();
      }),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'Your wishlist is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Text(
              'Tap the heart icon on any product to add it to your wishlist',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME_SCREEN);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItems() {
    return RefreshIndicator(
      onRefresh: () => controller.fetchWishlist(),
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.wishlistItems.length,
        itemBuilder: (context, index) {
          final product = controller.wishlistItems[index];
          return ProductCard(
            product: product,
            onTap: () => controller.navigateToProductDetail(product),
            showFavoriteButton: true,
          );
        },
      ),
    );
  }
}

class CustomAppBar {
}
