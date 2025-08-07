import '../models/store_product_model.dart';
import '../models/category_model.dart';

class StoreService {
  // Simulated API data - in a real app, this would come from an API
  static final List<CategoryModel> _categories = [
    CategoryModel(
      id: '1',
      name: 'Tops & Jackets',
      imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&h=400&fit=crop',
      description: 'Quality designer Italian tops and jackets',
      productCount: 18,
    ),
    CategoryModel(
      id: '2',
      name: 'Bottoms',
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=400&fit=crop',
      description: 'Elegant Italian bottoms and pants',
      productCount: 15,
    ),
    CategoryModel(
      id: '3',
      name: 'Dresses & Jumpsuits',
      imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400&h=400&fit=crop',
      description: 'Beautiful Italian dresses and jumpsuits',
      productCount: 12,
    ),
    CategoryModel(
      id: '4',
      name: 'Denim',
      imageUrl: 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400&h=400&fit=crop',
      description: 'Premium Italian denim collection',
      productCount: 8,
    ),
  ];

  static final List<StoreProductModel> _products = [
    StoreProductModel(
      id: '1',
      name: 'Oggi Stretch Pant',
      description: 'Premium Italian stretch pants with exceptional comfort and style',
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=500&fit=crop',
      price: 126.00,
      rating: 4.5,
      reviewCount: 128,
      isNew: true,
      categories: ['Bottoms'],
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Gray'],
      stockQuantity: 15,
    ),
    StoreProductModel(
      id: '2',
      name: 'Lepore Bomber',
      description: 'Italian designer bomber jacket with premium quality',
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&h=500&fit=crop',
      price: 174.00,
      rating: 4.2,
      reviewCount: 89,
      isNew: true,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy'],
      stockQuantity: 25,
    ),
    StoreProductModel(
      id: '3',
      name: 'Spaggia Skirt',
      description: 'Elegant Italian skirt perfect for any occasion',
      imageUrl: 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=400&h=500&fit=crop',
      price: 116.00,
      rating: 4.7,
      reviewCount: 156,
      isNew: true,
      categories: ['Bottoms'],
      sizes: ['S', 'M', 'L'],
      colors: ['Black', 'Navy', 'Gray'],
      stockQuantity: 8,
    ),
    StoreProductModel(
      id: '4',
      name: 'Dolci Shirt - Capri',
      description: 'Premium Italian shirt with Capri design',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=500&fit=crop',
      price: 166.80,
      rating: 4.3,
      reviewCount: 67,
      isNew: true,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Cream'],
      stockQuantity: 20,
    ),
    StoreProductModel(
      id: '5',
      name: 'Tuscany Pant',
      description: 'Classic Italian Tuscany pants with premium fit',
      imageUrl: 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=400&h=500&fit=crop',
      price: 156.00,
      rating: 4.8,
      reviewCount: 45,
      categories: ['Bottoms'],
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 5,
    ),
    StoreProductModel(
      id: '6',
      name: 'Dolci Bomber - Capri',
      description: 'Italian designer bomber with Capri styling',
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&h=500&fit=crop',
      price: 150.00,
      rating: 4.1,
      reviewCount: 234,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy'],
      stockQuantity: 30,
    ),
    StoreProductModel(
      id: '7',
      name: 'Amalfi Shirt',
      description: 'Elegant Italian Amalfi shirt with premium quality',
      imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&h=500&fit=crop',
      price: 174.00,
      originalPrice: 220.00,
      rating: 4.6,
      reviewCount: 78,
      isOnSale: true,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L'],
      colors: ['White', 'Black'],
      stockQuantity: 12,
    ),
    StoreProductModel(
      id: '8',
      name: 'Valeria Cotton Silk',
      description: 'Premium Italian cotton silk blend top',
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=500&fit=crop',
      price: 156.00,
      rating: 4.4,
      reviewCount: 156,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L'],
      colors: ['White', 'Cream'],
      stockQuantity: 18,
    ),
    StoreProductModel(
      id: '9',
      name: 'Isabella Dress with Rope Belt',
      description: 'Beautiful Italian dress with elegant rope belt detail',
      imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400&h=500&fit=crop',
      price: 166.80,
      rating: 4.7,
      reviewCount: 92,
      categories: ['Dresses & Jumpsuits'],
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 10,
    ),
    StoreProductModel(
      id: '10',
      name: 'Emilia Flower Knit',
      description: 'Italian flower knit with delicate design',
      imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=400&h=500&fit=crop',
      price: 108.00,
      rating: 4.3,
      reviewCount: 67,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['White', 'Cream'],
      stockQuantity: 22,
    ),
    StoreProductModel(
      id: '11',
      name: 'Dolci Dress - Capri',
      description: 'Elegant Italian Capri dress with premium styling',
      imageUrl: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400&h=500&fit=crop',
      price: 202.80,
      rating: 4.8,
      reviewCount: 45,
      isNew: true,
      categories: ['Dresses & Jumpsuits'],
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 8,
    ),
    StoreProductModel(
      id: '12',
      name: 'Lusso Blazer',
      description: 'Premium Italian blazer with luxury finish',
      imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&h=500&fit=crop',
      price: 174.00,
      originalPrice: 220.00,
      rating: 4.6,
      reviewCount: 78,
      isOnSale: true,
      categories: ['Tops & Jackets'],
      sizes: ['S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 12,
    ),
    StoreProductModel(
      id: '13',
      name: 'Dolci Terrace Silk Dress',
      description: 'Beautiful Italian silk dress with terrace design',
      imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400&h=500&fit=crop',
      price: 203.00,
      rating: 4.7,
      reviewCount: 92,
      categories: ['Dresses & Jumpsuits'],
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 10,
    ),
    StoreProductModel(
      id: '14',
      name: 'Lusso Split Pant',
      description: 'Italian luxury split pants with premium fit',
      imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=500&fit=crop',
      price: 167.00,
      rating: 4.4,
      reviewCount: 156,
      categories: ['Bottoms'],
      sizes: ['S', 'M', 'L'],
      colors: ['Black', 'Navy'],
      stockQuantity: 18,
    ),
    StoreProductModel(
      id: '15',
      name: 'Pompeii Denim Jean',
      description: 'Premium Italian denim jeans with Pompeii styling',
      imageUrl: 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400&h=500&fit=crop',
      price: 167.00,
      rating: 4.5,
      reviewCount: 128,
      categories: ['Denim'],
      sizes: ['26', '28', '30', '32', '34'],
      colors: ['Blue', 'Black'],
      stockQuantity: 25,
    ),
  ];

  // Get all categories
  static Future<List<CategoryModel>> getCategories() async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500));
    return _categories;
  }

  // Get all products
  static Future<List<StoreProductModel>> getProducts() async {
    await Future.delayed(Duration(milliseconds: 800));
    return _products;
  }

  // Get new arrivals
  static Future<List<StoreProductModel>> getNewArrivals() async {
    await Future.delayed(Duration(milliseconds: 300));
    return _products.where((product) => product.isNew).toList();
  }

  // Get products on sale
  static Future<List<StoreProductModel>> getSaleProducts() async {
    await Future.delayed(Duration(milliseconds: 400));
    return _products.where((product) => product.isOnSale).toList();
  }

  // Get products by category
  static Future<List<StoreProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(Duration(milliseconds: 600));
    final category = _categories.firstWhere((cat) => cat.id == categoryId);
    return _products.where((product) => product.categories.contains(category.name)).toList();
  }

  // Search products
  static Future<List<StoreProductModel>> searchProducts(String query) async {
    await Future.delayed(Duration(milliseconds: 700));
    return _products.where((product) => 
      product.name.toLowerCase().contains(query.toLowerCase()) ||
      product.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Toggle favorite status
  static Future<bool> toggleFavorite(String productId) async {
    await Future.delayed(Duration(milliseconds: 200));
    // In a real app, this would update the server
    return true;
  }
} 