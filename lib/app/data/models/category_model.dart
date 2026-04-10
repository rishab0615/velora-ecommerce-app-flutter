class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final int productCount;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description = '',
    this.productCount = 0,
    this.isActive = true,
  });
} 