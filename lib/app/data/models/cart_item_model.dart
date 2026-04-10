import 'store_product_model.dart';

class CartItemModel {
  final String id;
  final StoreProductModel product;
  final int quantity;
  final String selectedSize;


  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    });

  double get totalPrice => product.offerPrice * quantity;
  double get totalOriginalPrice => product.price * quantity;
  bool get hasDiscount => product.hasDiscount;

  CartItemModel copyWith({
    String? id,
    StoreProductModel? product,
    int? quantity,
    String? selectedSize,

  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      // selectedColor: selectedColor ?? this.selectedColor,

    );
  }
} 