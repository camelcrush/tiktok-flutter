import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Terminal Command

// 설치
// flutter pub add cloud_functions
// flutterfire configure

// 초기화 및  배포
// functions 폴더에서
// firebase init functions
// firebase deploy --only functions

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// Admin 권한으로 Cloud Function을 수행할 임시 서버 초기화
admin.initializeApp();

// Cloud Function은 임시 서버를 오픈하여 함수를 실행한 뒤에 꺼버림
// 임시 서버 내에는  System Packages Included in Cloud Functions를 가지고 있는데
// child-process-promise(spawn)를 활용하여 서버에서 터미널을 이용해 Package를 사용할 수 있음
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    // 서버 내 패키지 실행 프로그램 => 프로세스 내에 또 다른 프로세스
    const spawn = require("child-process-promise").spawn;
    // snapshot : firestore document
    const video = snapshot.data();
    // ffmpeg: A complete, cross-platform solution to record, convert and stream audio and video.
    // 배열 각 각 터미널 명령어로 처리 진행
    // -i : input file, -ss : 초단위 설정, -vframes : 첫번째 프레임 선택, -vf : 화면비율(가로:세로 -1은 가로비율대로 처리하라는 의미)
    // 마지막은 output file 위치와 파일명
    await spawn("ffmpeg", [
      "-i",
      video.fileUrl,
      "-ss",
      "00:00:01.000",
      "-vframes",
      "1",
      "-vf",
      "scale=150:-1",
      `/tmp/${snapshot.id}.jpg`,
    ]);
    // Firestorage로 썸내일 보내기
    const storage = admin.storage();
    const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
    // 파일 Public화한 후 document(snapshot)에 thumbnailUrl 업데이트
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

    // 데이터베이스 불러오기 & users/uid/videos/videoId 로 유저 프로파일 업데이트
    const db = admin.firestore();
    await db
      .collection("users")
      .doc(video.creatorUid)
      .collection("videos")
      .doc(snapshot.id)
      .set({ thumbnailUrl: file.publicUrl(), videoId: snapshot.id });
  });

// User의 favorite 리스트를 구성하여 보여주려면 users/likes/ 를 만들어 주는 function도 포함시켜줘야 함
export const onLikedCreated = functions.firestore
  .document("likes/{likeId}")
  .onCreate(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(1),
      });
  });

export const onLikedRemoved = functions.firestore
  .document("likes/{likeId}")
  .onDelete(async (snapshot, context) => {
    const db = admin.firestore();
    const [videoId, _] = snapshot.id.split("000");
    await db
      .collection("videos")
      .doc(videoId)
      .update({
        likes: admin.firestore.FieldValue.increment(-1),
      });
  });
