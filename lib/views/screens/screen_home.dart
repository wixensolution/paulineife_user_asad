import 'dart:io';

import 'package:album_image/album_image.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paulineife_user/controller/home_controller.dart';
import 'package:paulineife_user/helpers/theme.dart';
import 'package:paulineife_user/helpers/theme_service.dart';
import 'package:paulineife_user/views/layouts/layout_home.dart';
import 'package:paulineife_user/views/layouts/layout_notification.dart';
import 'package:paulineife_user/views/layouts/layout_profile.dart';
import 'package:paulineife_user/views/layouts/layout_search.dart';
import 'package:paulineife_user/views/screens/screen_post_image.dart';
import 'package:paulineife_user/views/screens/screen_post_text.dart';
import 'package:paulineife_user/views/screens/screen_post_video.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/gallery_grid/src/grid_gallery.dart';
import '../../helpers/helpers.dart';
import '../../widgets/custom_buttom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(HomeController());

  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      popAllScreensOnTapAnyTabs: true,
      screens: [
        HomeLayout(
          onStoryPressed: (selectedType) {
            switch (selectedType){
              case StoryType.gallery:
                testPicker();
                break;
              case StoryType.camera:
                getFromCameraimg(false);
                break;
            }
          },
        ),
        SearchLayout(),
        HomeLayout(
          onStoryPressed: (_) {

          },
        ),
        NotificationLayouts(),
        ProfileLayout(
          onThemeUpdate: () {
            setState(() {});
          },
          userName: controller.userName.value,
        ),
      ],
      items: [
        PersistentBottomNavBarItem(
          onPressed: (val) {
            setState(() {
              _controller.index = 0;
            });
          },
          icon: _controller.index == 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: ThemeService.isSavedDarkMode()
                      ? SvgPicture.asset("assets/svgs/Home_opened_black.svg")
                      : SvgPicture.asset("assets/svgs/Home_opened.svg"),
                )
              : ThemeService.isSavedDarkMode()
                  ? SvgPicture.asset("assets/svgs/Home_closed_black.svg")
                  : SvgPicture.asset("assets/svgs/Home_closed.svg"),
          activeColorPrimary: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
          title: ("Settings"),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          onPressed: (val) {
            setState(() {
              _controller.index = 1;
            });
          },
          icon: _controller.index == 1
              ? Padding(
                  padding: EdgeInsets.only(bottom: 6.0),
                  child: ThemeService.isSavedDarkMode()
                      ? SvgPicture.asset("assets/svgs/Search_opened_black.svg")
                      : SvgPicture.asset("assets/svgs/search_opened.svg"),
                )
              : Padding(
                  padding: EdgeInsets.only(bottom: 6.0),
                  child: ThemeService.isSavedDarkMode()
                      ? SvgPicture.asset("assets/svgs/Search_closed_black.svg")
                      : SvgPicture.asset("assets/svgs/search_closed.svg"),
                ),
          activeColorPrimary: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
          title: ("Settings"),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          onPressed: (val) {
            setState(() {
              _controller.index = 2;
              _controller.index = 0;
            });
            Get.bottomSheet(
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp),
                  ),
                  color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.sp),
                      child: Text(
                        'Create Post',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    ListTile(
                      onTap: () {
                        showPostBottomSheet();
                      },
                      leading: Icon(
                        Icons.camera_alt_outlined,
                        color: ThemeService.isSavedDarkMode()
                            ? Colors.white
                            : Color(
                                0xff97A1B4,
                              ),
                        size: 20.sp,
                      ),
                      title: Text(
                        'Image Post',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffE2E4EB),
                      thickness: 2.sp,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(PostTextScreen());
                      },
                      leading: Icon(
                        Icons.text_snippet_outlined,
                        color: ThemeService.isSavedDarkMode()
                            ? Colors.white
                            : Color(
                                0xff97A1B4,
                              ),
                        size: 20.sp,
                      ),
                      title: Text(
                        'Text Post',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffE2E4EB),
                      thickness: 2.sp,
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          Get.bottomSheet(
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.sp),
                                  topRight: Radius.circular(20.sp),
                                ),
                                color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
                              ),
                              height: 18.h,
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Get.back();
                                      getFromCameravid();
                                    },
                                    leading: Icon(
                                      Icons.camera_alt_outlined,
                                      color: ThemeService.isSavedDarkMode()
                                          ? Colors.white
                                          : Color(
                                              0xff97A1B4,
                                            ),
                                      size: 20.sp,
                                    ),
                                    title: Text(
                                      'Camera',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffE2E4EB),
                                    thickness: 2.sp,
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.back();
                                      setState(() {
                                        getFromGalleryvid();
                                      });
                                    },
                                    leading: Icon(
                                      Icons.photo,
                                      color: ThemeService.isSavedDarkMode()
                                          ? Colors.white
                                          : Color(
                                              0xff97A1B4,
                                            ),
                                      size: 20.sp,
                                    ),
                                    title: Text(
                                      'Gallery',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          );
                        });
                      },
                      leading: Icon(
                        Icons.videocam_outlined,
                        color: ThemeService.isSavedDarkMode()
                            ? Colors.white
                            : Color(
                                0xff97A1B4,
                              ),
                        size: 20.sp,
                      ),
                      title: Text(
                        'Video Post',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            );
          },
          icon: Padding(
            padding: EdgeInsets.only(bottom: 6.0),
            child: ThemeService.isSavedDarkMode() ? SvgPicture.asset("assets/svgs/Add_black.svg") : SvgPicture.asset("assets/svgs/add.svg"),
          ),
          activeColorPrimary: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          onPressed: (val) {
            setState(() {
              _controller.index = 3;
            });
          },
          icon: Badge(
            badgeContent: Text(
              '1',
              style: TextStyle(color: Colors.white),
            ),
            position: BadgePosition.topEnd(end: -7, top: -13),
            child: _controller.index == 3
                ? ThemeService.isSavedDarkMode()
                    ? SvgPicture.asset("assets/svgs/Notification_opened_black.svg")
                    : SvgPicture.asset("assets/svgs/Notification_opened.svg")
                : ThemeService.isSavedDarkMode()
                    ? SvgPicture.asset("assets/svgs/Notification_closed_black.svg")
                    : SvgPicture.asset("assets/svgs/Notification_closed.svg"),
          ),
          title: ("Settings"),
          activeColorPrimary: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          onPressed: (val) {
            setState(() {
              _controller.index = 4;
            });
          },
          icon: Padding(
            padding: EdgeInsets.only(bottom: 3.0),
            child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Color(0xff3AA0FF), width: 2.sp)),
                child: Obx(() {
                  return CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(controller.profileImage.value),
                  );
                })),
          ),
          title: ("Settings"),
          activeColorPrimary: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      confineInSafeArea: true,
      backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }

  void getFromGalleryvid() async {
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.video, allowMultiple: false);
    if (pickedFile != null) {
      setState(() {
        Get.to(PostVideoScreen());
        controller.vid = File(pickedFile.files.first.path!);
      });
    }
  }

  void getFromCameravid() async {
    final pickedFile = await ImagePicker().pickVideo(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        Get.to(PostVideoScreen());
        controller.vid = File(pickedFile.path);
      });
    }
  }

  void getFromGalleryimg(isGallery) async {
    // final pickedFile = await pickMultiImages();
    // if (pickedFile != null) {
    //   setState(() {
    //     controller.images = pickedFile;
    //     Get.to(PostImageScreen(
    //       isNormal: true,
    //     ));
    //     controller.img = controller.images[0];
    //   });
    // }
  }

  void getFromCameraimg(isGallery) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        Get.to(PostImageScreen(
          isNormal: true,
        ));
        controller.images.add(File(pickedFile.path));
        controller.img = controller.images[0];
      });
    }
  }

  // Future<List<File>?> pickMultiImages() async {
  //   List<Media>? res = await ImagesPicker.pick(
  //       count: 10, pickType: PickType.image, cropOpt: CropOption(aspectRatio: CropAspectRatio.custom, cropType: CropType.rect));
  //   return res?.map((e) => File(e.path)).toList();
  // }

  void testPicker() async {
    // Get.to(CustomGalleryPicker(onPicked: (files, isNormal) {}));
    Get.to(MyGallery());
  }

  void showPostBottomSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),
          ),
          color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
        ),
        height: 18.h,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.back();
                getFromCameraimg(false);
              },
              leading: Icon(
                Icons.camera_alt_outlined,
                color: ThemeService.isSavedDarkMode()
                    ? Colors.white
                    : Color(
                  0xff97A1B4,
                ),
                size: 20.sp,
              ),
              title: Text(
                'Camera',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),
            Divider(
              color: Color(0xffE2E4EB),
              thickness: 2.sp,
            ),
            ListTile(
              onTap: () {
                // Get.back();
                // getFromGalleryimg(true);
                // Get.to(CustomGalleryPicker(
                //   onPicked: (files, isNormal) {
                //     controller.images = files;
                //     controller.img = controller.images[0];
                //
                //     Get.to(PostImageScreen(isNormal: isNormal));
                //   },
                // ));

                testPicker();
              },
              leading: Icon(
                Icons.photo,
                color: ThemeService.isSavedDarkMode()
                    ? Colors.white
                    : Color(
                  0xff97A1B4,
                ),
                size: 20.sp,
              ),
              title: Text(
                'Gallery',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}

class MyGallery extends StatefulWidget {
  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  var galleryController = GalleryController(type: AssetType.image);
  File? clickedImage;
  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            "Create Post",
            style: getAppbarTextTheme(),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.images.clear();
              },
              icon: Icon(
                Icons.arrow_back,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
              )),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
              child: Column(
                children: [
                  if (controller.images.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5.sp),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: controller.images.map(
                                  (e) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5.sp),
                                          child: GestureDetector(
                                            child: Container(
                                              height: Get.width * .17,
                                              width: Get.width * .2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.sp),
                                                image: DecorationImage(image: FileImage(e), fit: BoxFit.cover),
                                              ),
                                            ),
                                            onTap: () {
                                              if (clickedImage == e) {
                                                clickedImage = null;
                                              } else {
                                                clickedImage = e;
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                        CustomButton1(
                          text: 'Select',
                          textStyle: TextStyle(color: Colors.black, fontSize: 13.sp),
                          onPressed: () {
                            // setState(() {
                            //   Get.bottomSheet(
                            //     Container(
                            //       height: 36.h + 5,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(20.sp),
                            //           topRight: Radius.circular(20.sp),
                            //         ),
                            //         color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
                            //       ),
                            //       child: Column(
                            //         children: [
                            //           Padding(
                            //             padding: EdgeInsets.only(top: 35.sp),
                            //             child: Text(
                            //               'Post',
                            //               style: TextStyle(
                            //                 fontSize: 22,
                            //                 fontWeight: FontWeight.w700,
                            //                 color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding: EdgeInsets.only(top: 15.sp),
                            //             child: Text(
                            //               'Post image as',
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 15.sp,
                            //           ),
                            //           ListTile(
                            //             onTap: () {
                            //               Get.to(PostImageScreen(
                            //                 isNormal: true,
                            //               ))!
                            //                   .then((value) {
                            //                 Navigator.pop(context);
                            //               });
                            //             },
                            //             leading: SvgPicture.asset(
                            //               'assets/svgs/gallery.svg',
                            //               color: ThemeService.isSavedDarkMode()
                            //                   ? Colors.white
                            //                   : Color(
                            //                       0xff97A1B4,
                            //                     ),
                            //             ),
                            //             title: Text(
                            //               'Normal images',
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //           Divider(
                            //             color: Color(0xffE2E4EB),
                            //             thickness: 2.sp,
                            //           ),
                            //           ListTile(
                            //             onTap: () {
                            //               Get.to(PostImageScreen(
                            //                 isNormal: false,
                            //               ))!
                            //                   .then((value) {
                            //                 Navigator.pop(context);
                            //               });
                            //               ;
                            //               // Navigator.pop(context);
                            //             },
                            //             leading: SvgPicture.asset(
                            //               'assets/svgs/thread.svg',
                            //               color: ThemeService.isSavedDarkMode()
                            //                   ? Colors.white
                            //                   : Color(
                            //                       0xff97A1B4,
                            //                     ),
                            //             ),
                            //             title: Text(
                            //               'Thread',
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.w400,
                            //                 color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     backgroundColor: Colors.transparent,
                            //     elevation: 0,
                            //     // isDismissible: false,
                            //     // enableDrag: false,
                            //   );
                            // });

                            showCupertinoModalPopup<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoActionSheet(
                                  title: Text('Post images as?'),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        // do something
                                        Navigator.pop(context);
                                        Get.to(PostImageScreen(
                                          isNormal: true,
                                        ));
                                      },
                                      child: Text('Normal Image'),
                                    ),
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        // do something
                                        Navigator.pop(context);
                                        Get.to(PostImageScreen(
                                          isNormal: false,
                                        ));
                                      },
                                      child: Text('Thread'),
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                );
                              },
                            );
                          },
                          color: Color(0xffE2E4EB),
                          height: 25.sp,
                          width: 65.sp,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ],
                    ),
                  if (controller.images.isNotEmpty && clickedImage != null)
                    ExtendedImage.file(
                      clickedImage!,
                      height: 30.h,
                      width: Get.width,
                      fit: BoxFit.cover,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) {
                        return getImageZoomScale();
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                final thumbnailQuality = MediaQuery.of(context).size.width ~/ 3;
                return AlbumImagePicker(
                  onSelected: (items) async {
                    // controller.images = items.map((e) => e.);

                    var selectedFiles = (await Future.wait(items.map((e) => e.file).toList())).map((e) => e!).toList();
                    controller.images = selectedFiles;
                    setState(() {});
                  },
                  selectionBuilder: (_, selected, index) {
                    if (selected) {
                      return CircleAvatar(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(fontSize: 10, height: 1.4),
                        ),
                        radius: 10,
                      );
                    }
                    return Container();
                  },
                  crossAxisCount: 3,
                  maxSelection: 10,
                  onSelectedMax: () {
                    print('Reach max');
                  },

                  // albumBackGroundColor: Colors.black,
                  appBarHeight: 45,
                  itemBackgroundColor: Colors.grey[100]!,
                  albumDividerColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
                  appBarColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
                  albumHeaderTextStyle: TextStyle(color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black, fontSize: 13.sp),
                  albumBackGroundColor: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
                  albumTextStyle: TextStyle(color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black, fontSize: 14),
                  albumSubTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  type: AlbumType.image,
                  // closeWidget: const BackButton(
                  //   color: Colors.black,
                  // ),
                  thumbnailQuality: thumbnailQuality * 3,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
