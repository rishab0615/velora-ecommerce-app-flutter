import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    } else {
      if (!user.emailVerified) {
        Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
      } else {
        Get.offAllNamed(Routes.HOME_SCREEN);
      }
    }
  }

  // Register User
  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await cred.user?.sendEmailVerification();

      await firestore.collection("users").doc(cred.user!.uid).set({
        "uid": cred.user!.uid,
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
      });

      Get.snackbar("Success", "Account created. Please verify your email.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = cred.user;

      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          Get.offAllNamed(Routes.EMAIL_VERIFICATION_SCREEN);
          await auth.signOut(); // force logout until verified
        } else {
          Get.offAllNamed(Routes.HOME_SCREEN);
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  void logout() async {
    await auth.signOut();
  }
}
