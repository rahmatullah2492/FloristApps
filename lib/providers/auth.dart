import 'package:firebase_auth/firebase_auth.dart';
import '../popup/pop_up.dart';

class FirebaseAuthService {
  // Tambahkan kelas FirebaseAuthService
  FirebaseAuth _auth = FirebaseAuth.instance; // Inisialisasi FirebaseAuth

  Future<User?> signUpWithEmailAndPassword(
      // Tambahkan fungsi signUpWithEmailAndPassword
      String email,
      String password,
      String username) async {
    // Tambahkan parameter email, password, dan username
    try {
      // Tambahkan try catch
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          // Tambahkan fungsi createUserWithEmailAndPassword
          email: email,
          password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: "The email address is already in use");
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signUpWithCredential(AuthCredential credential) async {
    // Tambahkan fungsi signUpWithGoogle
    try {
      // Gunakan signInWithCredential untuk mendaftar pengguna dengan kredensial
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Tambahkan kondisi jika password terlalu lemah
        showToast(
            message:
                'The password provided is too weak.'); // Tambahkan pesan kesalahan
      } else {
        showToast(
            message:
                "Error signing up with credential: $e"); // Tambahkan pesan kesalahan
      }
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithCredential(AuthCredential credential) async {
    // Tambahkan fungsi signInWithCredential
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(message: 'No user found for that email.');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
      return null;
    }
  }

  Future<void> forgotPassword(String email) async {
    // Ubah nama fungsi menjadi forgotPassword
    try {
      await _auth.sendPasswordResetEmail(
          email: email.trim()); // Mengirim email reset password
    } on FirebaseAuthException catch (e) {
      // Tambahkan try catch
      if (e.code == 'user-not-found') {
        showToast(message: 'No user found for that email.');
      } else {
        showToast(message: 'An error occured: ${e.code}');
      }
      return null;
    }
  }
}
