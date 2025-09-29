import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/store_screen_module/store_screen_controller.dart';
import 'package:amici/app/helper_widgets/store_widgets.dart';

import '../../data/services/store_service.dart';
import '../../routes/app_pages.dart';

class StoreScreenPage extends StatelessWidget {
   StoreScreenPage({super.key});
  final StoreScreenController controller = Get.find<StoreScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          child: CustomScrollView(
            slivers: [
              // Search Bar
              // _buildSearchSection(),
              SliverToBoxAdapter(
                child: SizedBox(height: 10),
              ),
              // Hero Carousel
              _buildHeroCarousel(),
              
              // Categories Section
              _buildCategoriesSection(),
              
              // New Arrivals Section
              _buildNewArrivalsSection(),
              
              // Sale Products Section
              _buildSaleProductsSection(),
              
              // Pre-Order Products Section
              _buildPreOrderSection(),
              
              // Search Results Section
              _buildSearchResultsSection(),
              
              // Bottom padding
              SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /// Search section with professional search bar
  Widget _buildSearchSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: StoreSearchBar(
          controller: TextEditingController(),
          onSearch: () {
            // Handle search
          },
          onClear: controller.clearSearch,
        ),
      ),
    );
  }

  /// Hero carousel with professional design
  Widget _buildHeroCarousel() {
    return SliverToBoxAdapter(
      child: Container(
        height: 220,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.carouselImages.length,
                onPageChanged: (index) {
                  controller.updateCarouselIndex(index);
                  controller.pauseAutoScroll();
                  // Resume auto-scroll after user interaction
                  Future.delayed(Duration(seconds: 5), () {
                    controller.resumeAutoScroll();
                  });
                },
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        controller.carouselImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey[400]),
                          );
                        },
                      ),
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
                      Positioned(
                        bottom: 14,
                        left: 14,
                        right: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Made In Italy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Quality Designer Italian Fashion',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            // Carousel Indicators
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.carouselImages.length,
                  (index) => Obx(() => GestureDetector(
                    onTap: () => controller.goToCarouselIndex(index),
                    child: Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentCarouselIndex.value == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Categories section with professional grid
  Widget _buildCategoriesSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoadingCategories.value) {
              return Container(
                height: 200,
                child: StoreLoadingIndicator(message: 'Loading categories...'),
              );
            }
            
            if (controller.categories.isEmpty) {
              return Container(
                height: 200,
                child: EmptyStateWidget(
                  title: 'No Categories',
                  message: 'Categories will appear here',
                  icon: Icons.category_outlined,
                ),
              );
            }

            return Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Container(
                    width: 148,
                    margin: EdgeInsets.only(right: 12),
                    child: CategoryTile(
                      category: category,
                      onTap: () => controller.navigateToCategory(category),
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// New arrivals section with professional product cards
  Widget _buildNewArrivalsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Arrivals',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.VIEW_ALL, arguments: {"title": "New Arrivals", "products": controller.newArrivals}),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoadingNewArrivals.value) {
              return Container(
                height: 248,
                child: StoreLoadingIndicator(message: 'Loading new arrivals...'),
              );
            }
            
            if (controller.newArrivals.isEmpty) {
              return Container(
                height: 248,
                child: EmptyStateWidget(
                  title: 'No New Arrivals',
                  message: 'New products will appear here',
                  icon: Icons.new_releases_outlined,
                ),
              );
            }

            return Container(
              height: 248,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.newArrivals.length,
                itemBuilder: (context, index) {
                  final product = controller.newArrivals[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    // onFavoriteToggle: () => controller.toggleFavorite(product),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Sale products section
  Widget _buildSaleProductsSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On Sale',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.VIEW_ALL, arguments: {"title": "On Sale", "products": controller.saleProducts}),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.isLoadingSaleProducts.value) {
              return Container(
                height: 248,
                child: StoreLoadingIndicator(message: 'Loading sale products...'),
              );
            }
            
            if (controller.saleProducts.isEmpty) {
              return Container(
                height: 248,
                child: EmptyStateWidget(
                  title: 'No Sale Products',
                  message: 'Sale products will appear here',
                  icon: Icons.local_offer_outlined,
                ),
              );
            }

            return Container(
              height: 248,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.saleProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.saleProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    // onFavoriteToggle: () => controller.toggleFavorite(product),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Pre-Order products section
  Widget _buildPreOrderSection() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pre-Order',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Month tabs (chips)
          Obx(() {
            // Explicitly read selected index to trigger rebuilds on change
            final selectedIndex = controller.selectedPreOrderMonthIndex.value;
            final months = controller.upcomingMonths;
            if (months.isEmpty) return SizedBox.shrink();
            return Container(
              height: 40,
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: months.length,
                separatorBuilder: (_, __) => SizedBox(width: 6),
                itemBuilder: (context, index) {
                  final dt = months[index];
                  final selected = selectedIndex == index;
                  final label = _formatMonth(dt);
                  return ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    onSelected: (_) => controller.selectPreOrderMonth(index),
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600),
                    backgroundColor: Colors.grey.shade200,
                    shape: StadiumBorder(side: BorderSide(color: selected ? Colors.black : Colors.grey.shade300)),
                  );
                },
              ),
            );
          }),
          Obx(() {
            // Explicitly read selected index to trigger list rebuilds
            final selectedIndex = controller.selectedPreOrderMonthIndex.value;
            if (controller.isLoadingPreOrders.value) {
              return Container(
                height: 248,
                child: StoreLoadingIndicator(message: 'Loading pre-order products...'),
              );
            }
            
            final items = controller.currentMonthPreOrders;
            if (items.isEmpty) {
              return Container(
                height: 200,
                child: EmptyStateWidget(
                  title: 'No Pre-Order Items',
                  message: 'Upcoming items for this month will appear here',
                  icon: Icons.event_available_outlined,
                ),
              );
            }

            return Container(
              height: 248,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    // onFavoriteToggle: () => controller.toggleFavorite(product),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  String _formatMonth(DateTime dt) {
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${names[dt.month - 1]} ${dt.year}';
  }

  /// Search results section
  Widget _buildSearchResultsSection() {
    return Obx(() {
      if (!controller.isSearchActive.value) {
        return SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            if (controller.isSearching.value)
              Container(
                height: 200,
                child: StoreLoadingIndicator(message: 'Searching...'),
              )
            else if (controller.searchResults.isEmpty)
              Container(
                height: 200,
                child: EmptyStateWidget(
                  title: 'No Results Found',
                  message: 'Try searching with different keywords',
                  icon: Icons.search_off,
                  actionText: 'Clear Search',
                  onActionPressed: controller.clearSearch,
                ),
              )
            else
              Container(
                height: 248,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final product = controller.searchResults[index];
                    return ProductCard(
                      product: product,
                      onTap: () => controller.navigateToProductDetail(product),
                      // onFavoriteToggle: () => controller.toggleFavorite(product),
                    );
                  },
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
