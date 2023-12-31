import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/views/screens/screen_terms_conditions.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/theme_service.dart';
import '../../widgets/custom_buttom.dart';

class SignUpGoogleScreen extends StatelessWidget {
  const SignUpGoogleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var WHeight = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
          title: Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w700,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.only(top: 12.sp),
                height: Get.height / 12,
                width: Get.width / 1.1,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffD6D9E3),
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  style: TextStyle(
                    color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                  ),
                  controller: TextEditingController(text: 'Example_123'),
                  decoration: InputDecoration(
                    label: Text(
                      'Username',
                      style: TextStyle(color: Color(0xff79869F), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5.sp, top: 10.sp),
                  padding: EdgeInsets.only(top: 12.sp),
                  height: Get.height / 12,
                  width: Get.width / 2.3,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD6D9E3),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(
                      color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                    ),
                    controller: TextEditingController(text: 'Example'),
                    decoration: InputDecoration(
                      label: Text(
                        'First Name',
                        style: TextStyle(color: Color(0xff79869F), fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.sp, top: 10.sp),
                  padding: EdgeInsets.only(top: 12.sp),
                  height: Get.height / 12,
                  width: Get.width / 2.3,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD6D9E3),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(
                      color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                    ),
                    controller: TextEditingController(text: 'Example'),
                    decoration: InputDecoration(
                      label: Text(
                        'Last Name',
                        style: TextStyle(color: Color(0xff79869F), fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            CustomButton1(
              text: 'Sign up',
              color: Color(0xff2A70C8),
              width: WHeight.width / 1.2,
              height: WHeight.height / 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.sp)),
              ),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
              ),
              onPressed: () {
                Get.to(TermsConditionsScreen());
              },
            ),
            SizedBox(
              height: WHeight.width / 6,
            ),
            TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                      text: 'Already Have an Account? ',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                      ),
                      children: [
                        TextSpan(text: ' Sign In', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Color(0xff2A70C8)))
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
