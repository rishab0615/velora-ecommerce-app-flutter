import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var quantity = 1.obs;
  var selectedSize = ''.obs;
  var selectedColor = ''.obs;

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) quantity--;
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(String color) {
    selectedColor.value = color;
  }

  void resetSelections() {
    selectedSize.value = '';
    selectedColor.value = '';
    quantity.value = 1;
  }
}
