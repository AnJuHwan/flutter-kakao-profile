import 'dart:io';

class UserModel {
  String? uid;
  String? docId;
  String name;
  String? discription;
  String? avatarUrl;
  String? backgroundUrl;
  File? avatarFile;
  File? backgroundFile;
  DateTime? lastLoginTime;
  DateTime? createdTime;

  UserModel({
    this.uid,
    this.docId,
    required this.name,
    this.discription,
    this.avatarUrl,
    this.backgroundUrl,
    this.lastLoginTime,
    this.createdTime,
  });
}
