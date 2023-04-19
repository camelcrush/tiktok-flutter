import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/users/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    // users collection을 생성하여 profile.uid값으로 document를 만들고 set(data)를 필드로 저장
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  // Firestore로부터 데이터 가져오기
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }
}

final userRepo = Provider((ref) => UserRepository());
