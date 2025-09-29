import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/data/models/store_product_model.dart';
import 'package:amici/app/helper_widgets/store_widgets.dart';
import 'package:amici/app/modules/category_module/category_controller.dart';
import 'package:amici/app/theme/app_colors.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  
  const CategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: blackColor,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: whiteColor,
        iconTheme: IconThemeData(color: blackColor),

      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          _buildFilterSortRow(controller),
          
          // Product Grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                );
              }
              
              if (controller.products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined, 
                        size: 64, 
                        color: Colors.grey[400]
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16, 
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    showFavoriteButton: true,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSortRow(CategoryController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2)),
      ]),
      child: Row(
        children: [
          // Sort Dropdown
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
              child:Obx(() => DropdownButton<String>(
                value: controller.selectedSort.value,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                items: controller.sortOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Sort: $value',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) controller.sortProducts(newValue);
                },
              )),
            ),
          ),

          SizedBox(width: 12),

          // Filter Button
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.tune_rounded, size: 20, color: Colors.black87),
          ),
        ],
      ),
    );
  }
  
  PopupMenuItem<String> _buildSortMenuItem(String title, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),
    );
  }
}
