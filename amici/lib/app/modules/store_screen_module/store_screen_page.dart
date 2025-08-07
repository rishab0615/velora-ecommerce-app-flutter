import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/store_screen_module/store_screen_controller.dart';
import 'package:amici/app/helper_widgets/store_widgets.dart';

class StoreScreenPage extends StatelessWidget {
   StoreScreenPage({super.key});
StoreScreenController controller = Get.put(StoreScreenController());
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
              _buildSearchSection(),
              
              // Hero Carousel
              _buildHeroCarousel(),
              
              // Categories Section
              _buildCategoriesSection(),
              
              // New Arrivals Section
              _buildNewArrivalsSection(),
              
              // Sale Products Section
              _buildSaleProductsSection(),
              
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        height: 250,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Made In Italy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Quality Designer Italian Fashion',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
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
              bottom: 60,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.carouselImages.length,
                  (index) => Obx(() => GestureDetector(
                    onTap: () => controller.goToCarouselIndex(index),
                    child: Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
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
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 16),
                    child: CategoryTile(
                      category: category,
                      onTap: () => controller.navigateToCategory(category),
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 32),
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Arrivals',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/new_arrivals'),
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
                height: 280,
                child: StoreLoadingIndicator(message: 'Loading new arrivals...'),
              );
            }
            
            if (controller.newArrivals.isEmpty) {
              return Container(
                height: 280,
                child: EmptyStateWidget(
                  title: 'No New Arrivals',
                  message: 'New products will appear here',
                  icon: Icons.new_releases_outlined,
                ),
              );
            }

            return Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.newArrivals.length,
                itemBuilder: (context, index) {
                  final product = controller.newArrivals[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    onFavoriteToggle: () => controller.toggleFavorite(product),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 32),
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On Sale',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/sale_products'),
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
                height: 280,
                child: StoreLoadingIndicator(message: 'Loading sale products...'),
              );
            }
            
            if (controller.saleProducts.isEmpty) {
              return Container(
                height: 280,
                child: EmptyStateWidget(
                  title: 'No Sale Products',
                  message: 'Sale products will appear here',
                  icon: Icons.local_offer_outlined,
                ),
              );
            }

            return Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.saleProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.saleProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () => controller.navigateToProductDetail(product),
                    onFavoriteToggle: () => controller.toggleFavorite(product),
                  );
                },
              ),
            );
          }),
          SizedBox(height: 32),
        ],
      ),
    );
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 24,
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
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final product = controller.searchResults[index];
                    return ProductCard(
                      product: product,
                      onTap: () => controller.navigateToProductDetail(product),
                      onFavoriteToggle: () => controller.toggleFavorite(product),
                    );
                  },
                ),
              ),
            SizedBox(height: 32),
          ],
        ),
      );
    });
  }
}
