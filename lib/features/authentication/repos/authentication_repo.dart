import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // FirebaseAuth.instance : Auth Class의 Instance 가져오기
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Repository Getter로서 firebase currenUser를 통해 user를 받아오고 로그인 여부를 알 수 있음
  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;
}

final authRepo = Provider((ref) => AuthenticationRepository());
