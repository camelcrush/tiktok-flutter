import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload video
  UploadTask uploadVideo(File video, String uid) {
    final fileRef = _storage.ref().child(
        "/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(video);
  }

  // save video
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) async {
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      // Pagenation for firestore
      // createdAt 기준에 따라 pagenation
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> likeVideo(String videoId, String userId) async {
    // 고유 id를 설정하여 경제적으로 db query를 실행함
    final query = _db.collection("likes").doc("${videoId}000$userId");
    final like = await query.get();
    if (!like.exists) {
      await query.set(
        {
          "createdAt": DateTime.now(),
        },
      );
    } else {
      await query.delete();
    }

    // 아래 방법은 firebase에서 너무 많은 비용을 초래함
    // final like= await _db
    //     .collection("likes")
    //     .where("videoId", isEqualTo: videoId)
    //     .where("userId", isEqualTo: userId)
    //     .get();
    // if (like.docs.isEmpty) {
    //   await _db.collection("likes").add({
    //     "videoId": videoId,
    //     "userId": userId,
    //   });
    // } else {
    //   //delete likes
    // }
  }
}

final videosRepo = Provider((ref) => VideosRepository());
