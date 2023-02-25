import 'dart:io';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/views/layouts/layout_home.dart';
import 'package:paulineife_user/widgets/custom_buttom.dart';
import 'package:paulineife_user/widgets/custom_input_field1.dart';
import 'package:sizer/sizer.dart';
import '../../controller/registration_controller.dart';
import 'package:appinio_video_player/appinio_video_player.dart' as appinio;



class PostVideoScreen extends StatefulWidget {
  PostVideoScreen({Key? key,}) : super(key: key);

  @override
  State<PostVideoScreen> createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends State<PostVideoScreen> {
  var controller = Get.put(RegistrationController());

  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(controller.vid!)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bool swtch = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
          centerTitle: true,
          actions: [
            CustomButton1(
              text: 'post',
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSansR',
                  color: Colors.white),
              onPressed: () {
                Get.to(HomeLayout());
              },
              color: Color(0xff2A70C8),
              height: 45.sp,
              width: 60.sp,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19)),
            ),
          ],
          toolbarHeight: 60.sp,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.chat_bubble,
                  color: Colors.black,
                ),
                title: Text(
                  'Allow Comments',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSansR',
                      color: Colors.black),
                ),
                trailing: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Switch(
                          value: swtch,
                          onChanged: (val) {
                            setState(() {
                              swtch = val;
                            });
                          });
                    }),
              ),
              Container(
                height: 60.h,
                child: CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController
                ),),
              CustomInputField1(
                hint: 'Add a caption',
                maxLines: 5,
                minLines: 1,
                contentPadding: EdgeInsets.only(left: 5,right: 5),
              ),
              SizedBox(height: 10.sp,),
            ],
          ),
        ),
      ),
    );
  }
}