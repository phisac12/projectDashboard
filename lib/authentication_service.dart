import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
      return 'Logado com sucesso!';
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<UserCredential?> signUp({String? email, String? password}) async {
    try {
     var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      return userCredential;
    } on FirebaseAuthException catch (e){
      return null;
    }
  }

  logOut() async {
      await _firebaseAuth.signOut();
  }
}