import 'dart:io';
import 'package:get/get.dart';
import 'package:kakao_profile/src/controller/image_crop_controller.dart';
import 'package:kakao_profile/src/model/user_model.dart';

enum ProfileImageType { THUMBNAIL, BACKGROUND }

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  UserModel originMyProfile = UserModel(
    name: '개발하는남자',
    discription: '굿굿',
  );
  Rx<UserModel> myProfile = UserModel().obs;

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
    File? file = await ImageCropController.to.selectImage();
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
    toggleEditProfile();
  }
}
