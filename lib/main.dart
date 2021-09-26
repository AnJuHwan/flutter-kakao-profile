import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_profile/src/profile.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.white),
      home: const Profile(),
    );
  }
}
