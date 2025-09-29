import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amici/app/modules/profile_screen_module/profile_screen_controller.dart';

import '../../data/global_controllers/auth_controller.dart';
import '../../routes/app_pages.dart';
import '../wishlist_module/wishlist_controller.dart';

class ProfileScreenPage extends GetView<ProfileScreenController> {
   ProfileScreenPage({super.key});
  final AuthController authController = Get.find<AuthController>();
final wController=Get.find<WishlistController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            _buildProfileHeader(),
            
            SizedBox(height: 24),
            
            // Quick Stats Section
            _buildQuickStats(),
            
            SizedBox(height: 24),
            
            // Menu Items Section
            _buildMenuItems(),
            
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Profile header with avatar and user info
  Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.grey[800]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20),
          
          // User Info
          Text(
            authController.user.value!.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          SizedBox(height: 8),
          
          Text(
            authController.user.value!.email,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          
          SizedBox(height: 4),
          
          Text(
            authController.user.value!.phoneNumber,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to edit profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Quick stats section
  Widget _buildQuickStats() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.shopping_bag,
              title: 'Orders',
              value: '12',
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Obx(()=>
               _buildStatCard(
                icon: Icons.favorite,
                title: 'Wishlist',
                value: wController.wishlistItems.length.toString(),
                color: Colors.red,
              ),
            ),
          ),
          // SizedBox(width: 16),
          // Expanded(
          //   child: _buildStatCard(
          //     icon: Icons.star,
          //     title: 'Reviews',
          //     value: '5',
          //     color: Colors.amber,
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Individual stat card
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Menu items section
  Widget _buildMenuItems() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            subtitle: 'Track your orders and view history',
            onTap: ()=>Get.toNamed(Routes.MY_ORDERS),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            subtitle: 'View your saved items',
            onTap: () {
              Get.toNamed(Routes.WISHLIST);
            },
          ),

          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Logout from your account',
            onTap: () {
              _showLogoutDialog();
            },
            isDestructive: true,
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.delete_outline,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            onTap: () {
showDeleteAccountDialog();
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

   void showDeleteAccountDialog() {
     Get.dialog(
       AlertDialog(
         title: const Text('Delete Account'),
         content: const Text(
           'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
         ),
         actions: [
           TextButton(
             onPressed: () => Get.back(),
             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
           ),
           TextButton(
             onPressed: () async {
               Get.back(); // Close the dialog
               try {
                 final authController = Get.find<AuthController>();
                 await authController.deleteAccount();
                 Get.offAllNamed(Routes.LOGIN_SCREEN); // Navigate to login after deletion
               } catch (e) {
                 Get.snackbar(
                   'Error',
                   'Failed to delete account. Please try again.',
                   snackPosition: SnackPosition.BOTTOM,
                 );
               }
             },
             child: const Text(
               'Delete',
               style: TextStyle(color: Colors.red),
             ),
           ),
         ],
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
       ),
       barrierDismissible: true,
     );
   }

   void _showLogoutDialog() {
     Get.dialog(
       AlertDialog(
         title: const Text('Logout'),
         content: const Text('Are you sure you want to logout?'),
         actions: [
           TextButton(
             onPressed: () => Get.back(),
             child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
           ),
           TextButton(
             onPressed: () {
               Get.back(); // Close the dialog
               // Call your logout function here
               final authController = Get.find<AuthController>();
               authController.logout();
             },
             child: const Text(
               'Logout',
               style: TextStyle(color: Colors.red),
             ),
           ),
         ],
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
       ),
       barrierDismissible: true,
     );
   }
  /// Individual menu item
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDestructive 
              ? Colors.red.withOpacity(0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDestructive ? Colors.red : Colors.grey[700],
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  /// Divider for menu items
  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 80,
      endIndent: 20,
      color: Colors.grey[200],
    );
  }


}
