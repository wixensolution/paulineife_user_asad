import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/views/screens/screen_login.dart';
import 'package:sizer/sizer.dart';

import '../../controller/registration_controller.dart';
import '../../widgets/custom_buttom.dart';

class NewPasswordScreen extends StatelessWidget {
   NewPasswordScreen({Key? key}) : super(key: key);
   bool isPasswordField = false;
   final _formKey = GlobalKey<FormState>();

   var controller = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    var WHeight = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: Text(
              'Forget Password',
              style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DMSansR',
                  color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children:[
            SizedBox(height: 10.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Color(0xffD6D9E3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 2),
                      child: Text(
                        'New Password',
                        style: TextStyle(
                            fontFamily: 'DMSansR',
                            color: Color(0xff79869F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { return  Container(
                      height: WHeight.height / 18,
                      child: TextFormField(
                        obscureText: isPasswordField,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Text is required";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordField = !isPasswordField;
                              });
                            },
                            icon: Icon(isPasswordField
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: '........',
                          hintStyle: TextStyle(
                              fontFamily: 'DMSansR',
                              color: Color(0xff000000),
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w400),
                          contentPadding:
                          EdgeInsets.only(left: 5, bottom: 5),
                        ),

                        // decoration: InputDecoration(
                        //   suffixIcon: IconButton(
                        //     onPressed: () {
                        //       visible = !visible;
                        //     },
                        //     icon: visible == false
                        //         ? Icon(Icons.visibility)
                        //         : Icon(Icons.visibility_off),
                        //   ),
                        //   hintText: '.......',
                        //   hintStyle: TextStyle(
                        //       fontFamily: 'DMSansR',
                        //       color: Color(0xff000000),
                        //       fontSize: 20.sp,
                        //       fontWeight: FontWeight.w400),
                        //   contentPadding: EdgeInsets.only(left: 5),
                        //   border: InputBorder.none,
                        //   focusedBorder: InputBorder.none,
                        //   enabledBorder: InputBorder.none,
                        //   errorBorder: InputBorder.none,
                        //   disabledBorder: InputBorder.none,
                        // ),
                      ),
                    ); },),
                    SizedBox(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: WHeight.height / 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Color(0xffD6D9E3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 2),
                      child: Text(
                        'New Password',
                        style: TextStyle(
                            fontFamily: 'DMSansR',
                            color: Color(0xff79869F),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                   StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { return  Container(
                     height: WHeight.height / 18,
                     child: TextFormField(
                       obscureText: isPasswordField,
                       keyboardType: TextInputType.emailAddress,
                       maxLines: 1,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return "Text is required";
                         }
                         return null;
                       },

                       decoration: InputDecoration(
                         suffixIcon: IconButton(
                           onPressed: () {
                             setState(() {
                               isPasswordField = !isPasswordField;
                             });
                           },
                           icon: Icon(isPasswordField
                               ? Icons.visibility
                               : Icons.visibility_off),
                         ),
                         enabledBorder: InputBorder.none,
                         focusedBorder: InputBorder.none,
                         border: InputBorder.none,
                         hintText: '........',
                         hintStyle: TextStyle(
                             fontFamily: 'DMSansR',
                             color: Color(0xff000000),
                             fontSize: 30.sp,
                             fontWeight: FontWeight.w400),
                         contentPadding:
                         EdgeInsets.only(left: 5, bottom: 5),
                       ),

                       // decoration: InputDecoration(
                       //   suffixIcon: IconButton(
                       //     onPressed: () {
                       //       visible = !visible;
                       //     },
                       //     icon: visible == false
                       //         ? Icon(Icons.visibility)
                       //         : Icon(Icons.visibility_off),
                       //   ),
                       //   hintText: '.......',
                       //   hintStyle: TextStyle(
                       //       fontFamily: 'DMSansR',
                       //       color: Color(0xff000000),
                       //       fontSize: 20.sp,
                       //       fontWeight: FontWeight.w400),
                       //   contentPadding: EdgeInsets.only(left: 5),
                       //   border: InputBorder.none,
                       //   focusedBorder: InputBorder.none,
                       //   enabledBorder: InputBorder.none,
                       //   errorBorder: InputBorder.none,
                       //   disabledBorder: InputBorder.none,
                       // ),
                     ),
                   ); },),
                    SizedBox(),
                  ],
                ),
              ),
            ),
            CustomButton1(
              text: 'Save',
              color: Color(0xff2A70C8),
              width: WHeight.width / 1.2,
              height: WHeight.height / 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.sp)),
              ),
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'DMSansR'),
              onPressed: () {
                Get.to(ScreenLogin());
              },
            ),
          ],
        ),
      ),
    );
  }
}