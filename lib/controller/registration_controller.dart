import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:email_validator/email_validator.dart';
//
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paulineife_user/views/screens/screen_login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/helpers.dart';
import '../helpers/firebase_utils.dart';
import '../models/user.dart';
import '../views/screens/screen_post_video.dart';

class RegistrationController extends GetxController {
  RxBool isChecked = false.obs;
  File? img;
  List<File> images = [];
  List videos = [];
  File? StoryImg;
  File? vid;
  RxBool liked = true.obs;
  void getFromCameravid() async {
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
        Get.to(PostVideoScreen());
        vid = File(pickedFile.path);
    }
  }
}
