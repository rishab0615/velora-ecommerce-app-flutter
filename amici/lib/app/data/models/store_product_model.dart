import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';

class StoreProductModel {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrls;
  final double price;
  final double offerPrice;
  final bool active;
  final bool onSale;
  final String category;
  final List<String> features;
  final String sku;
  final int stock;
  final double rating;
  final List<String> sizes;
  final bool isFavorite; // Local state
  final bool isNew;
  final bool isPreOrder;
  final DateTime? availableDate;

  StoreProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.price,
    required  this.offerPrice,
    required this.active,
    required this.onSale,
    required this.category,
    this.features = const [],
    required this.sku,
    required this.stock,
    this.rating = 0.0,
    this.sizes = const [],
    this.isFavorite = false,
    this.isNew = false,
    this.isPreOrder = false,
    this.availableDate,
  });

  double get discountPercentage {
    if (price > 0 && offerPrice != null && price > offerPrice!) {
      return ((price - offerPrice!) / price * 100).roundToDouble();
    }
    return 0.0;
  }

  bool get hasDiscount => (price > 0) && (offerPrice != null) && (price > offerPrice!);
  bool get isOutOfStock => stock <= 0;

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseAvailableDate(dynamic date) {
      if (date == null) return null;
      
      if (date is Timestamp) {
        return date.toDate();
      } else if (date is String) {
        return DateTime.tryParse(date);
      } else if (date is Map && date['_seconds'] != null) {
        // Handle Firestore timestamp format
        return DateTime.fromMillisecondsSinceEpoch(
          (date['_seconds'] as int) * 1000,
          isUtc: true,
        );
      }
      return null;
    }

    return StoreProductModel(
      id: json['id'] ?? json['documentID'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      price: (json['price'] ?? 0.0).toDouble(),
      offerPrice: (json['offerPrice'] ?? 0.0).toDouble(),
      active: json['active'] ?? false,
      onSale: json['onSale'] ?? false,
      category: json['category'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      sku: json['sku'] ?? '',
      stock: (json['stock'] ?? 0).toInt(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      sizes: List<String>.from(json['sizes'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
      isNew: json['isNew'] ?? false,
      isPreOrder: json['isPreOrder'] ?? false,
      availableDate: parseAvailableDate(json['availableDate']),
    );
  }

  StoreProductModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? imageUrls,
    double? price,
    double? offerPrice,
    bool? active,
    bool? onSale,
    String? category,
    List<String>? features,
    String? sku,
    int? stock,
    double? rating,
    List<String>? sizes,
    bool? isFavorite,
    bool? isPreOrder,
    DateTime? availableDate,
  }) {
    return StoreProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      active: active ?? this.active,
      onSale: onSale ?? this.onSale,
      category: category ?? this.category,
      features: features ?? this.features,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      sizes: sizes ?? this.sizes,
      isFavorite: isFavorite ?? this.isFavorite,
      isPreOrder: isPreOrder ?? this.isPreOrder,
      availableDate: availableDate ?? this.availableDate,
    );
  }
}