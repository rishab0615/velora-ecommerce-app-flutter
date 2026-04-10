import 'package:amici/app/modules/category_module/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    final categoryName = Get.arguments?['category'] ?? 'Category';
    Get.lazyPut(() => CategoryController(categoryName: categoryName));
  }
}