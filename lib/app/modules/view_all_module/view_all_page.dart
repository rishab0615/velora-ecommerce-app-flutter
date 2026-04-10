import 'package:amici/app/modules/view_all_module/view_all_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/helper_widgets/store_widgets.dart';
import 'package:amici/app/data/models/store_product_model.dart';

class ViewAllPage extends StatefulWidget {
  final String title;
  final List<StoreProductModel> products;

  const ViewAllPage({
    Key? key,
    required this.title,
    this.products = const [],
  }) : super(key: key);

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(ViewAllController());
    controller.setProducts(widget.products); // pass initial products
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ViewAllController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildFilterSortRow(controller),
          Expanded(child: _buildProductsGrid(controller)),
        ],
      ),
    );
  }

  Widget _buildFilterSortRow(ViewAllController controller) {
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

  Widget _buildProductsGrid(ViewAllController controller) {
    return Obx(() {
      if (controller.filteredProducts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text('No products found',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text('Check back later for new arrivals',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500])),
            ],
          ),
        );
      }

      return GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = controller.filteredProducts[index];
          return ProductCard(
            product: product,
            onTap: () => controller.navigateToProductDetail(product),
          );
        },
      );
    });
  }
}
