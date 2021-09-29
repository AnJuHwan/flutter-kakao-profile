import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kakao_profile/src/model/user_model.dart';

class FirebaseUserRepository {
  static Future<String?> signup(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference drf = await users.add(user.toMap());
    // 키값인 도큐먼트 아이디로 업데이트
    return drf.id;
  }

  static Future<UserModel?> findUserByUid(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot data = await users.where('uid', isEqualTo: uid).get();
    if (data.size == 0) {
      return null;
    } else {
      return UserModel.fromJson(data.docs[0].data(), data.docs[0].id);
    }
  }

  static updateLastLoginDate(String? docId, DateTime time) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(docId).update({"date_last_login": time});
  }
}
