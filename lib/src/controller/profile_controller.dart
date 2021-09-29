import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kakao_profile/src/controller/image_crop_controller.dart';
import 'package:kakao_profile/src/model/user_model.dart';
import 'package:kakao_profile/src/repository/firebase_user_repository.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel();
  Rx<UserModel> myProfile = UserModel().obs;

  Future<void> authStateChanges(User? firebaseUser) async {
    if (firebaseUser != null) {
      UserModel? userModel =
          await FirebaseUserRepository?.findUserByUid(firebaseUser.uid);
      if (userModel != null) {
        originMyProfile = userModel;
        FirebaseUserRepository.updateLastLoginDate(
            userModel.docId, DateTime.now());
      } else {
        originMyProfile = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName,
          avatarUrl: firebaseUser.photoURL,
          createdTime: DateTime.now(),
          lastLoginTime: DateTime.now(),
        );
        String? docId = await FirebaseUserRepository.signup(originMyProfile);
        originMyProfile.docId = docId;
      }
    }
    myProfile(UserModel.clone(originMyProfile));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isEditMyProfile(false);
    myProfile(UserModel.clone(originMyProfile));
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }

  void rollback() {
    myProfile.value.initImage();
    myProfile(UserModel.clone(originMyProfile));
    toggleEditProfile();
  }

  void updateName(String updateName) {
    myProfile.update((my) {
      my!.name = updateName;
    });
  }

  void updateDiscription(String updateDiscription) {
    myProfile.update((my) {
      my!.discription = updateDiscription;
    });
  }

  void pickImage(ProfileImageType type) async {
    File? file = await ImageCropController.to.selectImage(type);
    if (file == null) {
      return;
    }
    switch (type) {
      case ProfileImageType.THUMBNAIL:
        if (!isEditMyProfile.value) {
          return;
        }
        myProfile.update((my) {
          my!.avatarFile = file;
        });
        break;
      case ProfileImageType.BACKGROUND:
        myProfile.update((my) {
          my!.backgroundFile = file;
        });
        break;
      default:
        null;
    }
  }

  void save() {
    originMyProfile = myProfile.value;
    FirebaseUserRepository.updateData(originMyProfile.docId, originMyProfile);
    toggleEditProfile();
  }
}
