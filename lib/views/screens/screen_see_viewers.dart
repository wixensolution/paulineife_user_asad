import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/theme.dart';
import '../../helpers/theme_service.dart';
import '../../widgets/custom_input_field1.dart';

class SeeViewersScreen extends StatelessWidget {
  const SeeViewersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,

          elevation: 0,
          title: Text(
            'Views and likes',
            style: getAppbarTextTheme(),
          ),
          centerTitle: true,
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
        ),
        body: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(),
                  Column(
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        size: 30.sp,
                      ),
                      Text(
                        '10.9K',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.favorite_outlined, color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black, size: 30.sp),
                      Text(
                        '10.9K',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              ),
              CustomInputField1(
                textStyle: TextStyle(
                  color: ThemeService.isSavedDarkMode()
                      ? Colors.white
                      : Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide.none,
                ),
                fillColor: ThemeService.isSavedDarkMode() ? Color(0xff3d3d3d) : Color(0xffE2E4EB),
                prefix: Icon(Icons.search, color:  ThemeService.isSavedDarkMode() ? Colors.white : Color(0xff79869F)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
                hint: 'Search',
                hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:  ThemeService.isSavedDarkMode() ? Colors.white : Color(0xff79869F)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      leading: Container(
                        padding: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.sp,
                              color: Color(0xff2A70C8),
                            )),
                        child: CircleAvatar(
                          radius: 25.sp,
                          backgroundImage: AssetImage('assets/images/12.png'),
                        ),
                      ),
                      title: Text(
                        'Asad',
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w700, color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black),
                      ),
                      subtitle: Text(
                        '@asad',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Color(0xff2A70C8),
                        ),
                      ),
                      trailing: ElevatedButton(
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                          ),
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(Color(0xdff2A70C8)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
