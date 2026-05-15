import '../models/category_model.dart';
import '../models/store_product_model.dart';

/// Portfolio/demo catalog used in place of a Firebase product admin backend.
///
/// The data intentionally keeps the same fields used by StoreProductModel so
/// the app can move back to Firestore later without changing UI code.
class DummyProducts {
  static final List<StoreProductModel> products = [
    StoreProductModel(
      id: 'velora-linen-wrap-dress',
      name: 'Linen Wrap Midi Dress',
      description:
          'A breathable linen-blend wrap dress with a relaxed waist tie, soft drape, and day-to-evening polish.',
      imageUrls: [
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=1200&h=1600&fit=crop',
      ],
      price: 129.00,
      offerPrice: 99.00,
      active: true,
      onSale: true,
      category: 'Dresses',
      features: ['Linen blend', 'Adjustable wrap tie', 'Midi length'],
      sku: 'VEL-DRS-001',
      stock: 22,
      rating: 4.8,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-satin-slip-dress',
      name: 'Satin Slip Evening Dress',
      description:
          'Minimal satin slip dress with adjustable straps and a bias-cut silhouette for an elegant evening look.',
      imageUrls: [
        'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=1200&h=1600&fit=crop',
      ],
      price: 148.00,
      offerPrice: 148.00,
      active: true,
      onSale: false,
      category: 'Dresses',
      features: ['Bias cut', 'Adjustable straps', 'Soft satin finish'],
      sku: 'VEL-DRS-002',
      stock: 14,
      rating: 4.7,
      sizes: ['XS', 'S', 'M', 'L'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-tailored-wool-coat',
      name: 'Tailored Wool Blend Coat',
      description:
          'Structured wool-blend coat with clean lapels, deep pockets, and a timeless longline fit.',
      imageUrls: [
        'https://images.unsplash.com/photo-1548624313-0396c75e4b1a?w=1200&h=1600&fit=crop',
      ],
      price: 249.00,
      offerPrice: 199.00,
      active: true,
      onSale: true,
      category: 'Outerwear',
      features: ['Wool blend', 'Fully lined', 'Deep side pockets'],
      sku: 'VEL-OUT-001',
      stock: 9,
      rating: 4.9,
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    StoreProductModel(
      id: 'velora-cropped-trench',
      name: 'Cropped Cotton Trench Jacket',
      description:
          'Modern cropped trench jacket with storm flap detailing, lightweight cotton twill, and a boxy profile.',
      imageUrls: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=1200&h=1600&fit=crop',
      ],
      price: 179.00,
      offerPrice: 149.00,
      active: true,
      onSale: true,
      category: 'Outerwear',
      features: ['Cotton twill', 'Cropped fit', 'Water-resistant finish'],
      sku: 'VEL-OUT-002',
      stock: 16,
      rating: 4.6,
      sizes: ['XS', 'S', 'M', 'L'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-organic-cotton-shirt',
      name: 'Organic Cotton Poplin Shirt',
      description:
          'Crisp everyday poplin shirt made from organic cotton with a relaxed cut and curved hem.',
      imageUrls: [
        'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=1200&h=1600&fit=crop',
      ],
      price: 89.00,
      offerPrice: 72.00,
      active: true,
      onSale: true,
      category: 'Tops',
      features: ['Organic cotton', 'Relaxed fit', 'Curved hem'],
      sku: 'VEL-TOP-001',
      stock: 34,
      rating: 4.5,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    StoreProductModel(
      id: 'velora-ribbed-knit-tank',
      name: 'Ribbed Knit Tank Top',
      description:
          'Soft ribbed knit tank with a flattering scoop neckline, made for layering or warm-weather styling.',
      imageUrls: [
        'https://images.unsplash.com/photo-1485462537746-965f33f7f6a7?w=1200&h=1600&fit=crop',
      ],
      price: 42.00,
      offerPrice: 42.00,
      active: true,
      onSale: false,
      category: 'Tops',
      features: ['Ribbed knit', 'Scoop neck', 'Stretch comfort'],
      sku: 'VEL-TOP-002',
      stock: 46,
      rating: 4.4,
      sizes: ['XS', 'S', 'M', 'L'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-wide-leg-trousers',
      name: 'Wide Leg Tailored Trousers',
      description:
          'High-rise tailored trousers with pressed pleats and a fluid wide leg for office-to-weekend wear.',
      imageUrls: [
        'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=1200&h=1600&fit=crop',
      ],
      price: 118.00,
      offerPrice: 94.00,
      active: true,
      onSale: true,
      category: 'Bottoms',
      features: ['High rise', 'Pressed pleats', 'Wide leg'],
      sku: 'VEL-BOT-001',
      stock: 20,
      rating: 4.7,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    StoreProductModel(
      id: 'velora-straight-denim',
      name: 'Straight Fit Vintage Denim',
      description:
          'Classic straight-leg denim with a mid-blue wash, comfortable stretch, and a clean everyday fit.',
      imageUrls: [
        'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=1200&h=1600&fit=crop',
      ],
      price: 98.00,
      offerPrice: 98.00,
      active: true,
      onSale: false,
      category: 'Bottoms',
      features: ['Mid-blue wash', 'Straight fit', 'Comfort stretch'],
      sku: 'VEL-BOT-002',
      stock: 28,
      rating: 4.6,
      sizes: ['24', '26', '28', '30', '32'],
    ),
    StoreProductModel(
      id: 'velora-pleated-midi-skirt',
      name: 'Pleated Midi Skirt',
      description:
          'Lightweight pleated midi skirt with graceful movement and a comfortable elastic waistband.',
      imageUrls: [
        'https://images.unsplash.com/photo-1583496661160-fb5886a13d77?w=1200&h=1600&fit=crop',
      ],
      price: 86.00,
      offerPrice: 69.00,
      active: true,
      onSale: true,
      category: 'Bottoms',
      features: ['Pleated texture', 'Elastic waistband', 'Midi length'],
      sku: 'VEL-BOT-003',
      stock: 18,
      rating: 4.5,
      sizes: ['XS', 'S', 'M', 'L'],
    ),
    StoreProductModel(
      id: 'velora-leather-crossbody',
      name: 'Leather Crossbody Bag',
      description:
          'Compact leather crossbody with a magnetic flap, adjustable strap, and organized interior pocketing.',
      imageUrls: [
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=1200&h=1600&fit=crop',
      ],
      price: 159.00,
      offerPrice: 129.00,
      active: true,
      onSale: true,
      category: 'Accessories',
      features: ['Genuine leather', 'Adjustable strap', 'Interior pocket'],
      sku: 'VEL-ACC-001',
      stock: 12,
      rating: 4.8,
      sizes: ['One Size'],
    ),
    StoreProductModel(
      id: 'velora-silk-scarf',
      name: 'Printed Silk Square Scarf',
      description:
          'Pure silk square scarf with a refined floral print, finished edges, and versatile styling options.',
      imageUrls: [
        'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=1200&h=1600&fit=crop',
      ],
      price: 69.00,
      offerPrice: 69.00,
      active: true,
      onSale: false,
      category: 'Accessories',
      features: ['Pure silk', 'Floral print', 'Hand-rolled edge'],
      sku: 'VEL-ACC-002',
      stock: 31,
      rating: 4.6,
      sizes: ['One Size'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-minimal-sneaker',
      name: 'Minimal Leather Sneaker',
      description:
          'Clean low-profile leather sneaker with cushioned footbed and flexible rubber sole.',
      imageUrls: [
        'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=1200&h=1600&fit=crop',
      ],
      price: 132.00,
      offerPrice: 112.00,
      active: true,
      onSale: true,
      category: 'Shoes',
      features: ['Leather upper', 'Cushioned insole', 'Rubber outsole'],
      sku: 'VEL-SHO-001',
      stock: 25,
      rating: 4.7,
      sizes: ['6', '7', '8', '9', '10'],
    ),
    StoreProductModel(
      id: 'velora-heeled-ankle-boot',
      name: 'Heeled Suede Ankle Boot',
      description:
          'Soft suede ankle boot with a walkable block heel, almond toe, and side zip closure.',
      imageUrls: [
        'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=1200&h=1600&fit=crop',
      ],
      price: 188.00,
      offerPrice: 188.00,
      active: true,
      onSale: false,
      category: 'Shoes',
      features: ['Suede upper', 'Block heel', 'Side zip'],
      sku: 'VEL-SHO-002',
      stock: 11,
      rating: 4.8,
      sizes: ['6', '7', '8', '9'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-cashmere-cardigan',
      name: 'Cashmere Blend Cardigan',
      description:
          'Plush cashmere-blend cardigan with horn-look buttons and a relaxed, cozy silhouette.',
      imageUrls: [
        'https://images.unsplash.com/photo-1618354691373-d851c5c3a990?w=1200&h=1600&fit=crop',
      ],
      price: 168.00,
      offerPrice: 139.00,
      active: true,
      onSale: true,
      category: 'Knitwear',
      features: ['Cashmere blend', 'Button front', 'Relaxed fit'],
      sku: 'VEL-KNT-001',
      stock: 17,
      rating: 4.9,
      sizes: ['XS', 'S', 'M', 'L'],
    ),
    StoreProductModel(
      id: 'velora-merino-turtleneck',
      name: 'Merino Wool Turtleneck',
      description:
          'Fine-gauge merino wool turtleneck with breathable warmth and a neat slim fit.',
      imageUrls: [
        'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=1200&h=1600&fit=crop',
      ],
      price: 118.00,
      offerPrice: 118.00,
      active: true,
      onSale: false,
      category: 'Knitwear',
      features: ['Merino wool', 'Fine gauge', 'Slim fit'],
      sku: 'VEL-KNT-002',
      stock: 23,
      rating: 4.6,
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    StoreProductModel(
      id: 'velora-capsule-blazer',
      name: 'Capsule Single Breasted Blazer',
      description:
          'Sharp single-breasted blazer with structured shoulders, welt pockets, and a smooth lining.',
      imageUrls: [
        'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=1200&h=1600&fit=crop',
      ],
      price: 198.00,
      offerPrice: 158.00,
      active: true,
      onSale: true,
      category: 'Tailoring',
      features: ['Structured shoulder', 'Single breasted', 'Fully lined'],
      sku: 'VEL-TLR-001',
      stock: 15,
      rating: 4.8,
      sizes: ['XS', 'S', 'M', 'L'],
      isNew: true,
    ),
    StoreProductModel(
      id: 'velora-sleeveless-waistcoat',
      name: 'Sleeveless Tailored Waistcoat',
      description:
          'A polished tailored waistcoat with a V neckline, button front, and modern longline shape.',
      imageUrls: [
        'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=1200&h=1600&fit=crop',
      ],
      price: 104.00,
      offerPrice: 104.00,
      active: true,
      onSale: false,
      category: 'Tailoring',
      features: ['Button front', 'Longline shape', 'Tailored fit'],
      sku: 'VEL-TLR-002',
      stock: 19,
      rating: 4.5,
      sizes: ['XS', 'S', 'M', 'L'],
    ),
    StoreProductModel(
      id: 'velora-resort-maxi-dress',
      name: 'Resort Cotton Maxi Dress',
      description:
          'Easy cotton maxi dress with tiered panels, side pockets, and a holiday-ready silhouette.',
      imageUrls: [
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=1200&h=1600&fit=crop',
      ],
      price: 138.00,
      offerPrice: 138.00,
      active: true,
      onSale: false,
      category: 'Dresses',
      features: ['Cotton voile', 'Tiered skirt', 'Side pockets'],
      sku: 'VEL-DRS-003',
      stock: 0,
      rating: 4.4,
      sizes: ['XS', 'S', 'M', 'L'],
      isPreOrder: true,
      availableDate: DateTime(2026, 7, 15),
    ),
    StoreProductModel(
      id: 'velora-canvas-weekender',
      name: 'Canvas Weekender Tote',
      description:
          'Durable canvas weekender tote with leather handles, zip closure, and a roomy travel-ready interior.',
      imageUrls: [
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=1200&h=1600&fit=crop',
      ],
      price: 126.00,
      offerPrice: 99.00,
      active: true,
      onSale: true,
      category: 'Accessories',
      features: ['Heavy canvas', 'Leather handles', 'Zip closure'],
      sku: 'VEL-ACC-003',
      stock: 8,
      rating: 4.7,
      sizes: ['One Size'],
    ),
    StoreProductModel(
      id: 'velora-platform-sandal',
      name: 'Braided Platform Sandal',
      description:
          'Braided platform sandal with padded straps, lightweight sole, and warm-weather comfort.',
      imageUrls: [
        'https://images.unsplash.com/photo-1562273138-f46be4ebdf33?w=1200&h=1600&fit=crop',
      ],
      price: 92.00,
      offerPrice: 92.00,
      active: true,
      onSale: false,
      category: 'Shoes',
      features: ['Braided straps', 'Padded footbed', 'Lightweight platform'],
      sku: 'VEL-SHO-003',
      stock: 0,
      rating: 4.3,
      sizes: ['6', '7', '8', '9', '10'],
      isPreOrder: true,
      availableDate: DateTime(2026, 8, 1),
    ),
  ];

  static List<CategoryModel> get categories {
    final categoryNames = products.map((product) => product.category).toSet();

    return categoryNames.map((name) {
      final categoryProducts =
          products.where((product) => product.category == name).toList();

      return CategoryModel(
        id: name.toLowerCase().replaceAll(' ', '-'),
        name: name,
        imageUrl: categoryProducts.first.imageUrls.first,
        description: _categoryDescriptions[name] ?? '',
        productCount: categoryProducts.length,
      );
    }).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  static const Map<String, String> _categoryDescriptions = {
    'Accessories': 'Finishing touches for polished everyday styling.',
    'Bottoms': 'Tailored trousers, denim, and skirts built for repeat wear.',
    'Dresses': 'Effortless dresses for workdays, weekends, and evenings.',
    'Knitwear': 'Soft seasonal layers with premium hand feel.',
    'Outerwear': 'Coats and jackets designed for refined layering.',
    'Shoes': 'Comfort-focused footwear with clean modern shapes.',
    'Tailoring': 'Sharp separates for capsule wardrobe dressing.',
    'Tops': 'Versatile shirts, tanks, and easy layering pieces.',
  };
}
