import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/users/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    // users collection을 생성하여 profile.uid값으로 document를 만들고 set(data)를 필드로 저장
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  // Firestore로부터 데이터 가져오기
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> uploadAvatar(File file, String fileName) async {
    // Firestorage reference 만들기 : 폴더(주소) 만들기
    final fileRef = _storage.ref().child("avatars/$fileName");
    // 주소에 file 업로드
    await fileRef.putFile(file);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    // User Profile Update
    await _db.collection("users").doc(uid).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers(
      String authUserId) async {
    return _db.collection("users").where('uid', isNotEqualTo: authUserId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> findUserById(
      String userId) async {
    return _db.collection("users").doc(userId).get();
  }
}

final userRepo = Provider((ref) => UserRepository());
