import 'package:flutter/material.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ProfileScreenController extends GetxController {
  // User profile data
  final RxString userName = 'Trish D.'.obs;
  final RxString userEmail = 'trish@gmail.com'.obs;
  final RxString userPhone = '+23 454545645'.obs;
  final RxString userAvatar = ''.obs;
  
  // User stats
  final RxInt orderCount = 12.obs;
  final RxInt wishlistCount = 8.obs;
  final RxInt reviewCount = 5.obs;
  
  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isUpdatingProfile = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  /// Load user profile data
  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      // Simulate API call
      await Future.delayed(Duration(milliseconds: 500));
      
      // Load user data from local storage or API
      // userName.value = await getUserName();
      // userEmail.value = await getUserEmail();
      // userPhone.value = await getUserPhone();
      // userAvatar.value = await getUserAvatar();
      
      // Load user stats
      await loadUserStats();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load user statistics
  Future<void> loadUserStats() async {
    try {
      // Simulate API calls for stats
      await Future.wait([
        Future.delayed(Duration(milliseconds: 200)),
        Future.delayed(Duration(milliseconds: 300)),
        Future.delayed(Duration(milliseconds: 400)),
      ]);
      
      // Update stats from API
      // orderCount.value = await getOrderCount();
      // wishlistCount.value = await getWishlistCount();
      // reviewCount.value = await getReviewCount();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load statistics: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatar,
  }) async {
    try {
      isUpdatingProfile.value = true;
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      // Update local values
      if (name != null) userName.value = name;
      if (email != null) userEmail.value = email;
      if (phone != null) userPhone.value = phone;
      if (avatar != null) userAvatar.value = avatar;
      
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdatingProfile.value = false;
    }
  }

  /// Navigate to wishlist
  void navigateToWishlist() {
    Get.toNamed('/wishlist');
  }

  /// Navigate to orders
  void navigateToOrders() {
    Get.toNamed('/orders');
  }

  /// Navigate to shipping addresses
  void navigateToAddresses() {
    Get.toNamed('/addresses');
  }

  /// Navigate to payment methods
  void navigateToPaymentMethods() {
    Get.toNamed('/payment_methods');
  }

  /// Navigate to help and support
  void navigateToHelp() {
    Get.toNamed('/help');
  }

  /// Navigate to change password
  void navigateToChangePassword() {
    Get.toNamed('/change_password');
  }

  /// Navigate to settings
  void navigateToSettings() {
    Get.toNamed('/settings');
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      // Clear user data
      userName.value = '';
      userEmail.value = '';
      userPhone.value = '';
      userAvatar.value = '';
      
      // Navigate to login
      Get.offAllNamed('/login');
      
      Get.snackbar(
        'Account Deleted',
        'Your account has been successfully deleted.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh profile data
  Future<void> refreshProfile() async {
    await loadUserProfile();
  }

  /// Get formatted stats
  String getFormattedOrderCount() => orderCount.value.toString();
  String getFormattedWishlistCount() => wishlistCount.value.toString();
  String getFormattedReviewCount() => reviewCount.value.toString();
}
