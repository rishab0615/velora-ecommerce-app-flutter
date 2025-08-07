import 'store_product_model.dart';

class CartItemModel {
  final String id;
  final StoreProductModel product;
  final int quantity;
  final String selectedSize;
  final String selectedColor;
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
    required this.addedAt,
  });

  double get totalPrice => product.price * quantity;
  double get totalOriginalPrice => product.originalPrice * quantity;
  bool get hasDiscount => product.hasDiscount;

  CartItemModel copyWith({
    String? id,
    StoreProductModel? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    DateTime? addedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      addedAt: addedAt ?? this.addedAt,
    );
  }
} 