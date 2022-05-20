
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class WriteMessageService{

  static FirebaseFirestore db = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage=FirebaseStorage.instanceFor(bucket: "gs://helpexfyp.appspot.com/");

  static UploadTask uploadFile(String image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(File(image));
    return uploadTask;
  }

  static Stream<QuerySnapshot> getChatStream(String recieverID,String currentUserId,int l) {
    return db
        .collection("messages").where("recieverID",isEqualTo: recieverID).where("senderID",isEqualTo: currentUserId).orderBy("timestamp",descending: true)
        .snapshots();
  }


  static Future<String?> sendMessage(String content, int type, String senderID, String recieverID,String name) async {

    try {
      DateTime dateToday =DateTime.now();
      String date = dateToday.toString();
      final temp1 = <String, dynamic>{
        "content": content,
        "type": type,
        "senderID":senderID,
        "recieverID":recieverID,
        "timestamp":DateTime.now().millisecondsSinceEpoch.toString(),
        "name":name
      };
      await db.collection("messages").add(temp1);

      return "1";
    } on FirebaseException catch (e) {
      return e.message;
    }

    // MessageChat messageChat = MessageChat(
    //   idFrom: currentUserId,
    //   idTo: peerId,
    //   timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
    //   content: content,
    //   type: type,
    // );
    //
    // FirebaseFirestore.instance.runTransaction((transaction) async {
    //   transaction.set(
    //     documentReference,
    //     messageChat.toJson(),
    //   );
    // });
  }
  

}