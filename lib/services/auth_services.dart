import 'package:firebase_auth/firebase_auth.dart';
import 'package:unimy_beacon_navigation/provider/root_change_notifier.dart';
import 'package:unimy_beacon_navigation/services/database_services.dart';
import 'package:unimy_beacon_navigation/viewstate.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future signIn({
    required String email,
    required String password,
    required RootChangeNotifier changeNotifier,
  }) async {
    try {
      changeNotifier.setState(ViewState.BUSY);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      changeNotifier.setState(ViewState.IDLE);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      changeNotifier.setState(ViewState.IDLE);
      throw e.message!;
    }
  }

  Future<String> signUp({
    required String email,
    required String password,
    required String displayName,
    required RootChangeNotifier changeNotifier,
  }) async {
    try {
      changeNotifier.setState(ViewState.BUSY);
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // final task = await StorageService.uploadFile(
      //         destination: data['destination'], file: data['file'])
      //     .whenComplete(() {});
      // profilePicUrl = await task.ref.getDownloadURL();

      await DatabaseService(uid: userCredential.user!.uid)
          .createUserData(email: email, name: displayName);

      changeNotifier.setState(ViewState.IDLE);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      changeNotifier.setState(ViewState.IDLE);
      throw e.message!;
    } catch (e) {
      changeNotifier.setState(ViewState.IDLE);
      throw e.toString();
    }
  }

  Future signOut(
    RootChangeNotifier changeNotifier,
  ) async {
    try {
      changeNotifier.setState(ViewState.BUSY);
      await _firebaseAuth.signOut();
      changeNotifier.setState(ViewState.IDLE);
      return "signout";
    } on FirebaseAuthException catch (e) {
      changeNotifier.setState(ViewState.IDLE);
      throw e.message!;
    }
  }
}
