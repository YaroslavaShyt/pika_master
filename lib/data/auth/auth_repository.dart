import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pika_master/core/logger/logger.dart';
import 'package:pika_master/data/user/app_user.dart';
import 'package:pika_master/domain/auth/iauth_repository.dart';
import 'package:pika_master/domain/user/iapp_user.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<IAppUser?> loginGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(googleAuthCredential);

      if (userCredential.user == null ||
          userCredential.user?.uid == null ||
          userCredential.user?.displayName == null) {
        return null;
      }

      return AppUser(
        id: userCredential.user!.uid,
        name: userCredential.user!.displayName!,
        email: userCredential.user?.email,
        profilePhoto: userCredential.user?.photoURL,
      );
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();

      return _firebaseAuth.currentUser == null;
    } catch (error) {
      logger.e(error);
      return false;
    }
  }
}
