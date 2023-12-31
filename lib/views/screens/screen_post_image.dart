import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/controller/home_controller.dart';
import 'package:paulineife_user/views/screens/screen_home.dart';
import 'package:paulineife_user/widgets/custom_buttom.dart';
import 'package:paulineife_user/widgets/custom_input_field1.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/theme.dart';
import '../../helpers/theme_service.dart';

class PostImageScreen extends StatefulWidget {
  PostImageScreen({
    required this.isNormal,
  });

  bool isNormal;

  @override
  State<PostImageScreen> createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen> {
  var controller = Get.find<HomeController>();
  bool isNormal = false;
  List<TextEditingController> textEditControllers = [];

  @override
  void initState() {
    isNormal = widget.isNormal;
    super.initState();
    for (int i = 0; i <= controller.images.length; i++) {
      textEditControllers.add(TextEditingController());
    }
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);
    int a = 0;
    bool swtch = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Post',
            style: getAppbarTextTheme(),
          ),
          centerTitle: true,
          backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Get.to(HomeScreen());
                  controller.images.clear();
                });
              },
              icon: Icon(
                Icons.arrow_back,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
              )),
          actions: [
            Obx(() {
              return CustomButton1(
                text: Get.find<HomeController>().uploadPostsLoading.isTrue ? 'Posting' : 'Post',
                textStyle: TextStyle(color: Colors.white),
                onPressed: Get.find<HomeController>().uploadPostsLoading.isTrue
                    ? null
                    : () {
                        // Get.to(HomeScreen());
                        if (isNormal) {
                          Get.find<HomeController>().uploadNormalPost(
                            textEditControllers.map((e) => e.text).toList(),
                            controller.images,
                          );
                        } else {
                          // List<ThreadPost> postsList = [];
                          // controller.images.forEach((element) {
                          //   int index = controller.images.indexOf(element);
                          //   postsList.add(ThreadPost(caption: textEditControllers[index].text, image: element));
                          // });
                          Get.find<HomeController>().uploadThreadPost(textEditControllers.first.text, controller.images);
                        }
                      },
                color: Color(0xff2A70C8),
                height: 35.sp,
                width: 60.sp,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              );
            }),
          ],
          // leading: IconButton(
          //     onPressed: () {
          //       Get.back();
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: ThemeService.isSavedDarkMode()
          //           ? Colors.black
          //           : Colors.white,
          //     )),
          toolbarHeight: 65.sp,
        ),
        backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        body: GetBuilder<HomeController>(
            init: Get.find<HomeController>(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble,
                            color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                          ),
                          SizedBox(
                            width: 6.sp,
                          ),
                          Text(
                            'Allow Comments',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                            ),
                          ),
                          Spacer(),
                          StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                            return Switch(
                                activeColor: ThemeService.isSavedDarkMode() ? Colors.white : Color(0xff3AA0FF),
                                activeTrackColor: ThemeService.isSavedDarkMode() ? Color(0xff3d3d3d) : Color(0xffD5EBFF),
                                inactiveTrackColor: ThemeService.isSavedDarkMode() ? Colors.grey : Color(0xffD5EBFF),
                                value: swtch,
                                onChanged: (val) {
                                  setState(() {
                                    swtch = val;
                                  });
                                });
                          }),
                        ],
                      ),
                    ),
                    isNormal == true
                        ? Container(
                            height: 66.5.h,
                            child: StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return PageView.builder(
                                  itemCount: controller.images.length,
                                  controller: _pageController,
                                  physics: BouncingScrollPhysics(),
                                  // reverse: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  onPageChanged: (val) {
                                    setState(() {
                                      a = val;
                                    });
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10.sp),
                                          height: 50.5.h,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: FileImage(controller.images[a]), fit: BoxFit.cover),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              controller.images.length > 1
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {});
                                                        if (a == controller.images.length - 1) {
                                                          if (controller.images.length >= 3) {
                                                            controller.images.removeAt(a);
                                                            a = a - 2;
                                                          }
                                                          if (controller.images.length == 2) {
                                                            controller.images.removeAt(1);
                                                            a = 0;
                                                          }
                                                        } else if (controller.images.length == 2) {
                                                          controller.images.removeAt(1);
                                                        } else if (controller.images.length < 2) {
                                                          controller.images.removeAt(0);
                                                          controller.update();
                                                        } else if (controller.images.length > 2) {
                                                          controller.images.removeAt(a);
                                                          controller.update();
                                                        }

                                                        controller.update();
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: SvgPicture.asset(
                                                          'assets/svgs/delete.svg',
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10.sp),
                                          child: CustomInputField1(
                                            controller: textEditControllers[a],
                                            hint: 'Add a caption',
                                            textStyle: TextStyle(
                                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                            ),
                                            hintStyle: TextStyle(color: Color(0xff666666)),
                                            maxLines: 5,
                                            minLines: 1,
                                            contentPadding: EdgeInsets.only(left: 5, right: 5),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.sp),
                                    height: 50.5.h,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: FileImage(controller.images[a]), fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        controller.images.length > 1
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {});
                                                  if (a == controller.images.length - 1) {
                                                    if (controller.images.length >= 3) {
                                                      controller.images.removeAt(a);
                                                      a = a - 2;
                                                    }
                                                    if (controller.images.length == 2) {
                                                      controller.images.removeAt(1);
                                                      a = 0;
                                                    }
                                                  } else if (controller.images.length == 2) {
                                                    controller.images.removeAt(1);
                                                  } else if (controller.images.length < 2) {
                                                    controller.images.removeAt(0);
                                                    controller.update();
                                                  } else if (controller.images.length > 2) {
                                                    controller.images.removeAt(a);
                                                    controller.update();
                                                  }

                                                  controller.update();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                    'assets/svgs/delete.svg',
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.sp),
                                    child: CustomInputField1(
                                      hint: 'Add a caption',
                                      hintStyle: TextStyle(color: Color(0xff666666)),
                                      textStyle: TextStyle(
                                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                      ),
                                      maxLines: 5,
                                      minLines: 1,
                                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    isNormal == true
                        ? StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return Container(
                                height: 75.sp,
                                child: ListView.builder(
                                  itemCount: controller.images.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.update();
                                          a = index;
                                          _pageController = PageController(initialPage: index);
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(8.sp),
                                        alignment: Alignment.center,
                                        height: 70.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.sp),
                                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                          image: DecorationImage(
                                              image: FileImage(
                                                controller.images[index],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return Container(
                                height: 75.sp,
                                child: ListView.builder(
                                  itemCount: controller.images.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.update();
                                          a = index;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(8.sp),
                                        alignment: Alignment.center,
                                        height: 70.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.sp),
                                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                          image: DecorationImage(
                                              image: FileImage(
                                                controller.images[index],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                    SizedBox(
                      height: 10.sp,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
