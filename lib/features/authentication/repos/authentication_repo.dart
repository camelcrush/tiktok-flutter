import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // FirebaseAuth.instance : Auth Class의 Instance 가져오기
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Repository Getter로서 firebase currenUser를 통해 user를 받아오고 로그인 여부를 알 수 있음
  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  // Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
  Stream<User?> authStateChange() => _firebaseAuth.authStateChanges();

  // Firebase에서 유저 생성하기
  Future<void> emailSignUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

// Repository expose
final authRepo = Provider((ref) => AuthenticationRepository());

// Creates a stream and exposes its latest event.
// Router에서 ref.watch(authState);를 통해 변화를 감지하면 router를 Rerender하므로
// Redirect 로직이 작동하여 SignUp화면으로 이동
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChange();
});
