import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/controller/home_controller.dart';
import 'package:paulineife_user/controller/otp_controller.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/theme.dart';
import '../../helpers/theme_service.dart';
import '../../widgets/custom_buttom.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List txt = [
      'It’s a spam',
      'Suicide or self-injury',
      'Hate speech or symbols',
      'Nudity or sexual activity',
      'Violence or dangerous organization',
      'Bullying or harassment',
      'I just don’t like it',
      'False information',
      'Sale of illegal or regulated goods',
      'Scam or fraud',
      'Intecllectual property violation',
      'Eating disorders'
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            'Report',
            style: getAppbarTextTheme(),

          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ThemeService.isSavedDarkMode()
                    ? Colors.white
                    : Colors.black,
              )),
          centerTitle: true,
          backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 6.sp),
                child: Text(
                  'Why are you reporting this post?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 6.sp),
                child: Text(
                  "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color:ThemeService.isSavedDarkMode() ? Colors.white :  Color(0xff79869F),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: txt.length,
                itemBuilder: (BuildContext context, int index) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                    return SizedBox(
                      height: 32.sp,
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.sp),
                        side: BorderSide(color:Color(0xff79869F) ),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          txt[index],
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400, color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black),
                        ),
                        value: controller.isChecked.value,
                        onChanged: (newValue) {
                          setState(() {
                            controller.isChecked.value = newValue!;
                          });
                        },
                      ),
                    );
                  });
                },
              ),
              CustomButton1(
                margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
                text: 'Submit',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                ),
                elevation: 0,
                height: Get.height / 14,
                width: Get.width,
                color: Color(0xff2A70C8),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
