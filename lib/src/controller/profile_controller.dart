import 'package:get/get.dart';
import 'package:kakao_profile/src/model/user_model.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;
  Rx<UserModel> myProfile = UserModel(
    name: '개발하는남자',
    discription: '굿굿',
  ).obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isEditMyProfile(false);
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
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
}
