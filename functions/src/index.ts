import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Terminal Command

// 설치
// flutter pub add cloud_functions
// flutterfire configure

// 초화 및  배포
// firebase init functions
// firebase deploy --only functions

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  .onCreate(async (snapshot, context) => {
    await snapshot.ref.update({ hello: "from functions" });
  });
