import '../models/cart_item_model.dart';
import '../models/store_product_model.dart';

class CartService {
  static final List<CartItemModel> _cartItems = [
    // Demo cart items for testing
    CartItemModel(
      id: '1',
      product: StoreProductModel(
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
      quantity: 2,
      selectedSize: 'M',
      selectedColor: 'Black',
      addedAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    CartItemModel(
      id: '2',
      product: StoreProductModel(
        id: '2',
        name: 'Lepore Bomber',
        description: 'Italian designer bomber jacket with premium quality',
        imageUrl: 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400&h=500&fit=crop',
        price: 174.00,
        originalPrice: 220.00,
        rating: 4.2,
        reviewCount: 89,
        isNew: true,
        isOnSale: true,
        categories: ['Tops & Jackets'],
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Black', 'Navy'],
        stockQuantity: 25,
      ),
      quantity: 1,
      selectedSize: 'L',
      selectedColor: 'Navy',
      addedAt: DateTime.now().subtract(Duration(hours: 3)),
    ),
  ];

  // Get all cart items
  static List<CartItemModel> getCartItems() {
    return _cartItems;
  }

  // Add item to cart
  static void addToCart(StoreProductModel product, {
    required String size,
    required String color,
    int quantity = 1,
  }) {
    // Check if item already exists with same size and color
    final existingIndex = _cartItems.indexWhere((item) => 
      item.product.id == product.id && 
      item.selectedSize == size && 
      item.selectedColor == color
    );

    if (existingIndex != -1) {
      // Update quantity of existing item
      final existingItem = _cartItems[existingIndex];
      _cartItems[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      final newItem = CartItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        product: product,
        quantity: quantity,
        selectedSize: size,
        selectedColor: color,
        addedAt: DateTime.now(),
      );
      _cartItems.add(newItem);
    }
  }

  // Remove item from cart
  static void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
  }

  // Update item quantity
  static void updateQuantity(String itemId, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1 && newQuantity > 0) {
      final item = _cartItems[index];
      _cartItems[index] = item.copyWith(quantity: newQuantity);
    } else if (index != -1 && newQuantity <= 0) {
      removeFromCart(itemId);
    }
  }

  // Clear cart
  static void clearCart() {
    _cartItems.clear();
  }

  // Get cart total
  static double getCartTotal() {
    return _cartItems.fold(0.0, (total, item) => total + item.totalPrice);
  }

  // Get cart total with original prices
  static double getCartOriginalTotal() {
    return _cartItems.fold(0.0, (total, item) => total + item.totalOriginalPrice);
  }

  // Get total savings
  static double getTotalSavings() {
    return getCartOriginalTotal() - getCartTotal();
  }

  // Get cart item count
  static int getCartItemCount() {
    return _cartItems.fold(0, (count, item) => count + item.quantity);
  }

  // Check if cart is empty
  static bool isCartEmpty() {
    return _cartItems.isEmpty;
  }

  // Get shipping cost
  static double getShippingCost() {
    final total = getCartTotal();
    return total >= 100 ? 0.0 : 15.0; // Free shipping over $100
  }

  // Get final total with shipping
  static double getFinalTotal() {
    return getCartTotal() + getShippingCost();
  }

  // Check if free shipping applies
  static bool hasFreeShipping() {
    return getCartTotal() >= 100;
  }
} 