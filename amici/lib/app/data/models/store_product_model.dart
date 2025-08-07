class StoreProductModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool isOnSale;
  final List<String> categories;
  final List<String> sizes;
  final List<String> colors;
  final int stockQuantity;
  final bool isFavorite;

  StoreProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.originalPrice = 0.0,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isNew = false,
    this.isOnSale = false,
    this.categories = const [],
    this.sizes = const [],
    this.colors = const [],
    this.stockQuantity = 0,
    this.isFavorite = false,
  });

  double get discountPercentage {
    if (originalPrice > 0 && originalPrice > price) {
      return ((originalPrice - price) / originalPrice * 100).roundToDouble();
    }
    return 0.0;
  }

  bool get hasDiscount => originalPrice > 0 && originalPrice > price;
  bool get isOutOfStock => stockQuantity <= 0;

  StoreProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    bool? isNew,
    bool? isOnSale,
    List<String>? categories,
    List<String>? sizes,
    List<String>? colors,
    int? stockQuantity,
    bool? isFavorite,
  }) {
    return StoreProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isNew: isNew ?? this.isNew,
      isOnSale: isOnSale ?? this.isOnSale,
      categories: categories ?? this.categories,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
} 