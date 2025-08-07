import '../../app/modules/product_detail_module/product_detail_page.dart';
import '../../app/modules/product_detail_module/product_detail_bindings.dart';
import '../../app/data/models/store_product_model.dart';
import '../../app/modules/profile_screen_module/profile_screen_page.dart';
import '../../app/modules/profile_screen_module/profile_screen_bindings.dart';
import '../../app/modules/my_cart_module/my_cart_page.dart';
import '../../app/modules/my_cart_module/my_cart_bindings.dart';
import '../../app/modules/store_screen_module/store_screen_page.dart';
import '../../app/modules/store_screen_module/store_screen_bindings.dart';
import '../../app/modules/home_screen_module/home_screen_page.dart';
import '../../app/modules/home_screen_module/home_screen_bindings.dart';
import '../../app/modules/onboarding_screen_module/onboarding_screen_page.dart';
import '../../app/modules/onboarding_screen_module/onboarding_screen_bindings.dart';
import '../../app/modules/sign_up_screen_module/sign_up_screen_page.dart';
import '../../app/modules/sign_up_screen_module/sign_up_screen_bindings.dart';
import '../../app/modules/login_screen_module/login_screen_page.dart';
import '../../app/modules/login_screen_module/login_screen_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_page.dart';
import '../../app/modules/splash_screen_module/splash_screen_bindings.dart';
import '../../app/modules/my_app_module/my_app_bindings.dart';
import '../../app/modules/my_app_module/my_app_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.MY_APP,
      page: () => MyAppPage(),
      binding: MyAppBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => LoginScreenPage(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP_SCREEN,
      page: () => SignUpScreenPage(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING_SCREEN,
      page: () => OnboardingScreenPage(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => HomeScreenPage(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: Routes.STORE_SCREEN,
      page: () => StoreScreenPage(),
      binding: StoreScreenBinding(),
    ),
    GetPage(
      name: Routes.MY_CART,
      page: () => MyCartPage(),
      binding: MyCartBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_SCREEN,
      page: () => ProfileScreenPage(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAIL,
      page: () => ProductDetailPage(product: Get.arguments ?? StoreProductModel(
        id: '',
        name: '',
        description: '',
        imageUrl: '',
        price: 0.0,
      )),
      binding: ProductDetailBinding(),
    ),
  ];
}
