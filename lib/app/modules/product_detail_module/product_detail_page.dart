import 'package:amici/app/data/models/cart_item_model.dart';
import 'package:amici/app/modules/my_cart_module/my_cart_controller.dart';
import 'package:amici/app/modules/product_detail_module/product_detail_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/store_product_model.dart';
import '../category_module/category_controller.dart';
import '../wishlist_module/wishlist_controller.dart';

class ProductDetailPage extends StatelessWidget {
  final StoreProductModel product;
  final ProductDetailController controller = Get.put(ProductDetailController());
final wishlistController = Get.find<WishlistController>();
final MyCartController cartController = Get.find<MyCartController>();
  ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Hero Image
          _buildSliverAppBar(),
          
          // Product Details
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title and Brand
                  _buildProductHeader(),
                  
                  SizedBox(height: 16),
                  
                  // Price and Rating
                  _buildPriceAndRating(),
                  //
                  SizedBox(height: 24),
                  
                  // Size Selection
                  _buildSizeSelection(),
                  
                  // SizedBox(height: 24),
                  //
                  // // Color Selection
                  // _buildColorSelection(),
                  
                  SizedBox(height: 24),
                  
                  // Description
                  _buildDescription(),
                  
                  SizedBox(height: 24),
                  
                  // Product Features
                  _buildProductFeatures(),
                  
                  SizedBox(height: 24),
                  
                  // Reviews Section
                  _buildReviewsSection(),
                  
                  SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Floating Action Button for Add to Cart
      floatingActionButton:  _buildAddToCartButton(cartController),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Custom Sliver App Bar with Hero Image
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
        backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Obx(  () {
            final isFavorite = wishlistController.wishlistItems.any((item) => item.id == product.id);
      return
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color:isFavorite ? Colors.red : Colors.black),
              onPressed: ()=>wishlistController.toggleWishlist(product)
            );

          }
          ),
        ),
        SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Carousel for multiple images
            Hero(
              tag: product.id,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,

                ),
                items: product.imageUrls.map((url) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),

            // Made in Italy Badge
            Positioned(
              top: 100,
              right: 20,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Made in Italy",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),

            // Sale Badge
            if (product.hasDiscount)
              Positioned(
                top: 100,
                left: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "-${product.discountPercentage.toInt()}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }

  /// Product Header with Title and Brand
  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "AMICI Fashion",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          product.name,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  /// Price and Rating Section
  Widget _buildPriceAndRating() {
    return Row(
      children: [
        // Rating
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: Colors.amber[50],
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(Icons.star, color: Colors.amber, size: 16),
        //       SizedBox(width: 4),
        //       Text(
        //         "${product.rating}",
        //         style: TextStyle(
        //           fontSize: 14,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.amber[800],
        //         ),
        //       ),
        //       SizedBox(width: 4),
        //                      Text(
        //          "(${product.reviewCount} reviews)",
        //          style: TextStyle(
        //            fontSize: 12,
        //            color: Colors.grey[600],
        //          ),
        //        ),
        //     ],
        //   ),
        // ),


        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                         Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 if (product.hasDiscount) ...[
                   Text(
                     "\$${product.price.toStringAsFixed(2)}",
                     style: TextStyle(
                       fontSize: 16,
                       color: Colors.grey[500],
                       decoration: TextDecoration.lineThrough,
                     ),
                   ),
                   SizedBox(height: 4),
                 ],
                 Text(
                   "\$${product.offerPrice.toStringAsFixed(2)}",
                   style: TextStyle(
                     fontSize: 28,
                     fontWeight: FontWeight.bold,
                     color: Colors.black87,
              ),
                 ),
                 if (product.price < 200) // Show free shipping for items under $200
                   Text(
                     "Free shipping over \$100",
                     style: TextStyle(
                       fontSize: 12,
                       color: Colors.green[600],
                       fontWeight: FontWeight.w500,
                     ),
                   ),
               ],
             ),
          ],
        ),
      ],
    );
  }

  /// Size Selection
  Widget _buildSizeSelection() {
    final sizes = product.sizes.isNotEmpty ? product.sizes : ['XS', 'S', 'M', 'L', 'XL'];
    
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
        Text(
          "Select Size",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
                  Row(
          children: sizes.map((size) {
            return Container(
              margin: EdgeInsets.only(right: 12),
              child: Obx(() => GestureDetector(
                onTap: () => controller.selectSize(size),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: controller.selectedSize.value == size 
                        ? Colors.black 
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: controller.selectedSize.value == size 
                          ? Colors.black 
                          : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: controller.selectedSize.value == size 
                            ? Colors.white 
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              )),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Color Selection
  // Widget _buildColorSelection() {
  //   final colors = product.colors.isNotEmpty ? product.colors : ['Black', 'Navy', 'White'];
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Select Color",
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       SizedBox(height: 12),
  //       Row(
  //         children: colors.map((color) {
  //           return Container(
  //             margin: EdgeInsets.only(right: 16),
  //             child: Obx(() => GestureDetector(
  //               onTap: () => controller.selectColor(color),
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       color: _getColorValue(color),
  //                       shape: BoxShape.circle,
  //                       border: Border.all(
  //                         color: controller.selectedColor.value == color
  //                             ? Colors.black
  //                             : Colors.grey[300]!,
  //                         width: controller.selectedColor.value == color ? 3 : 1,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 4),
  //                   Text(
  //                     color,
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey[600],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             )),
  //           );
  //         }).toList(),
  //       ),
  //     ],
  //   );
  // }

  /// Description Section
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          product.description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Product Features
  Widget _buildProductFeatures() {
    final features = product.features;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Features",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        ...features.map((feature) => Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                feature,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  /// Reviews Section
  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Customer Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Get.snackbar(
                  "Reviews",
                  "View all reviews",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Text(
                "View All",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
                  ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600]),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    children: [
                        Text(
                          "Sarah M.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: List.generate(5, (index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Beautiful quality! The fabric is amazing and the fit is perfect. Highly recommend!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Add to Cart Button
  /// Add to Cart Button
  Widget _buildAddToCartButton(MyCartController cartController) {
    return Obx(() {
      final isInCart = cartController.cartItems.any((item) => item.product.id == product.id);
      final isOutOfStock = product.stock <= 0;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isInCart ? Colors.grey[400] : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: isOutOfStock
              ? null
              : () {
            if (isInCart) {
              Get.snackbar(
                'Already in Cart',
                'This item is already in your shopping cart',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.grey[800],
                colorText: Colors.white,
                duration: Duration(seconds: 2),
              );
              Get.toNamed('/cart'); // Optional: Navigate to cart
            } else {
              if (controller.selectedSize.value.isEmpty) {
                Get.snackbar(
                  'Select Size',
                  'Please select a size before adding to cart',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red[400],
                  colorText: Colors.white,
                );
                return;
              }
              cartController.addToCart(
                CartItemModel(
                  product: product,
                  quantity: 1,
                  selectedSize: controller.selectedSize.value,
                  id: product.id,
                ),
              );
              Get.snackbar(
                'Added to Cart',
                '${product.name} has been added to your cart',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green[400],
                colorText: Colors.white,
                duration: Duration(seconds: 2),
              );
            }
          },
          child: Text(
            isOutOfStock
                ? 'Out of Stock'
                : isInCart ? 'Already in Cart' : 'Add to Cart - \$${product.offerPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
  /// Helper method to get color value
  Color _getColorValue(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'navy':
        return Colors.indigo[900]!;
      case 'white':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }
}
