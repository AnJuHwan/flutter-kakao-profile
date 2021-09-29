import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_profile/src/controller/profile_controller.dart';
import 'package:kakao_profile/src/page/login.dart';
import 'package:kakao_profile/src/page/profile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        ProfileController.to.authStateChanges(snapshot.data);
        if (!snapshot.hasData) {
          return LoginWidget();
        } else {
          return Profile();
        }
      },
    );
  }
}
