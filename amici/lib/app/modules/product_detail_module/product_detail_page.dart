import 'package:amici/app/modules/product_detail_module/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/store_product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final StoreProductModel product;
  final ProductDetailController controller = Get.put(ProductDetailController());

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
                  
                  SizedBox(height: 24),
                  
                  // Size Selection
                  _buildSizeSelection(),
                  
                  SizedBox(height: 24),
                  
                  // Color Selection
                  _buildColorSelection(),
                  
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
      floatingActionButton: _buildAddToCartButton(),
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
          child: IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Get.snackbar(
                "Added to Wishlist",
                "${product.name} added to your wishlist",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.black,
                colorText: Colors.white,
              );
            },
          ),
        ),
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
          child: IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              Get.snackbar(
                "Shared",
                "Product shared successfully",
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.black,
                colorText: Colors.white,
              );
            },
          ),
        ),
        SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
        children: [
            // Hero Image
          Hero(
            tag: product.id,
            child: Container(
                width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
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
      ),
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 4),
              Text(
                "${product.rating}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[800],
                ),
              ),
              SizedBox(width: 4),
                             Text(
                 "(${product.reviewCount} reviews)",
                 style: TextStyle(
                   fontSize: 12,
                   color: Colors.grey[600],
                 ),
               ),
            ],
          ),
        ),
        
        Spacer(),
        
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
                         Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 if (product.hasDiscount) ...[
                   Text(
                     "\$${product.originalPrice.toStringAsFixed(2)}",
                     style: TextStyle(
                       fontSize: 16,
                       color: Colors.grey[500],
                       decoration: TextDecoration.lineThrough,
                     ),
                   ),
                   SizedBox(height: 4),
                 ],
                 Text(
                   "\$${product.price.toStringAsFixed(2)}",
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
  Widget _buildColorSelection() {
    final colors = product.colors.isNotEmpty ? product.colors : ['Black', 'Navy', 'White'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Color",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: colors.map((color) {
            return Container(
              margin: EdgeInsets.only(right: 16),
              child: Obx(() => GestureDetector(
                onTap: () => controller.selectColor(color),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getColorValue(color),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: controller.selectedColor.value == color 
                              ? Colors.black 
                              : Colors.grey[300]!,
                          width: controller.selectedColor.value == color ? 3 : 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      color,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )),
            );
          }).toList(),
        ),
      ],
    );
  }

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
    final features = [
      "Premium Italian quality",
      "Natural fibers",
      "Designed in Italy",
      "Free shipping over \$100",
      "Easy returns",
    ];

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
  Widget _buildAddToCartButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Quantity Selector
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
                        children: [
                          IconButton(
                            onPressed: controller.decreaseQuantity,
                  icon: Icon(Icons.remove, color: Colors.black),
                          ),
                Obx(() => Text(
                  controller.quantity.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                          IconButton(
                            onPressed: controller.increaseQuantity,
                  icon: Icon(Icons.add, color: Colors.black),
                          ),
                        ],
            ),
          ),
          
          SizedBox(width: 16),
          
          // Add to Cart Button
          Expanded(
            child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                elevation: 0,
                        ),
                        onPressed: () {
                Get.snackbar(
                  "Added to Cart",
                  "${product.name} added to your cart",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
                        },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(width: 8),
                  Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
