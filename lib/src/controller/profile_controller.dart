import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isEditMyProfile = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isEditMyProfile(false);
  }

  void toggleEditProfile() {
    isEditMyProfile(!isEditMyProfile.value);
  }
}
