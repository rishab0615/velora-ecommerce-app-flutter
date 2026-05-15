class FirebaseAuthErrorMapper {
  static String message(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
        return 'Invalid email or password';

      case 'user-not-found':
        return 'No account found';

      case 'email-already-in-use':
        return 'An account already exists with this email';

      case 'weak-password':
        return 'Password should be at least 6 characters';

      case 'invalid-email':
        return 'Invalid email address';

      case 'email-not-verified':
        return 'Please verify your email before logging in.';

      case 'verification-email-sent':
        return 'Verification email sent. Please verify and login.';

      case 'firestore-user-create-failed':
        return 'Account setup failed. Please try logging in again.';

      case 'user-disabled':
        return 'This account has been disabled';

      case 'network-request-failed':
        return 'No internet connection';

      case 'too-many-requests':
        return 'Too many attempts. Try again later';

      case 'operation-not-allowed':
        return 'Authentication is currently unavailable';

      default:
        return 'Authentication failed';
    }
  }
}
