import 'dart:convert';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:paulineife_user/constant/constant.dart';
import 'package:paulineife_user/extensions/cap_extension.dart';
import 'package:paulineife_user/views/screens/screen_chat.dart';
import 'package:paulineife_user/views/screens/screen_comments.dart';
import 'package:paulineife_user/views/screens/screen_report.dart';
import 'package:paulineife_user/views/screens/screen_see_viewers.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_top_panel/sliding_top_panel.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../controller/login_controller.dart';
import '../../helpers/helpers.dart';
import '../../helpers/theme_service.dart';
import '../../models/Login.dart';
import '../../models/api/PostModel.dart';
import 'screen_story_view_more_text.dart';

class StoryViewScreen extends StatefulWidget {
  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();

  List<Post> storiesList;
  String username, userImage;
  DateTime timestamp;

  StoryViewScreen({
    required this.storiesList,
    required this.username,
    required this.userImage,
    required this.timestamp,
  });
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  ValueNotifier<bool> _isPanelVisible = ValueNotifier(false);
  SlidingPanelTopController _controller = SlidingPanelTopController();

  StoryController controller = StoryController();
  List<StoryItem> storyItems = [];
  MyStoryController indexController = Get.put(MyStoryController());

  // int randomNumber = 1;
  var StryCount;

  @override
  void initState() {
    super.initState();
    // _generateRandomNumber();
    StryCount = widget.storiesList.length;
    super.initState();
    _controller.addListener(listenerController);
    initStoryPageItems();
  }

  // List<int> numbers = [10, 12, 15, 5, 8, 7, 9, 6];

  // void _generateRandomNumber() {
  //   // Generate a random index using the Random class
  //   int randomIndex = Random().nextInt(numbers.length);
  //
  //   // Access the element at the random index
  //   setState(() {
  //     randomNumber = numbers[randomIndex];
  //   });
  // }

  void listenerController() {
    _isPanelVisible.value = _controller.isPanelOpen;
  }

  @override
  void dispose() {
    _controller.removeListener(listenerController);
    // _controller.dispose();
    super.dispose();
  }

  void initStoryPageItems() {
    // for (int i = 0; i < StryCount; i++) {
    //   storyItems.add(StoryItem.pageImage(
    //     url: 'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    //     controller: controller,
    //   ));
    // }

    storyItems = widget.storiesList.map((e) {
      return e.isImage
          ? StoryItem.pageImage(
              url: "$domainUrlWithProtocol${e.getImage!}",
              controller: controller,
            )
          : StoryItem.pageVideo(e.getVideo.toString(), controller: controller);
    }).toList();
  }

  void initi() {
    _controller.addListener(listenerController);
    initStoryPageItems();
    // _generateRandomNumber();
    // StryCount = randomNumber;
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SlidingTopPanel(
          maxHeight: 27.h,
          decorationPanel: BoxDecoration(
            color: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          controller: _controller,
          header: Container(),
          panel: (_) => _buildListPanel(),
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: StoryView(
                    storyItems: storyItems,
                    controller: controller,
                    onVerticalSwipeComplete: (direction) {
                      if (direction == Direction.down) {
                        Navigator.pop(context);
                      }
                      if (direction == Direction.up) {
                        storyItems.clear();
                        initi();
                      }
                    },
                    onStoryShow: (item) {
                      if (mounted) {
                        // setState(() {
                        //   _index = storyItems.indexOf(item);
                        // });
                        indexController.currentIndex.value = storyItems.indexOf(item);
                        var story = widget.storiesList[indexController.currentIndex.value];
                        indexController.updateViews(story.id);

                        var index = storyItems.indexOf(item);
                        print("Index: $index");
                        print("Image: ${widget.storiesList[index].getImage}");
                        print("Video: ${widget.storiesList[index].getVideo}");
                      }
                    },
                    onComplete: () {
                      Navigator.pop(context);
                    },
                    indicatorColor: Colors.white,
                  ),
                ),
                Positioned(
                  top: 10.sp,
                  left: 0,
                  right: 0,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(right: 0, left: 10.sp),
                    leading: Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.sp,
                            color: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
                          )),
                      child: CircleAvatar(
                        radius: 20.sp,
                        backgroundImage: ExtendedNetworkImageProvider("$domainUrlWithProtocol${widget.userImage}"),
                      ),
                    ),
                    title: Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                      ),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                          text: 'Good Football   ',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: widget.timestamp.toRelativeTimeShort,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                              ),
                            ),
                          ]),
                    ),
                    trailing: Container(
                      height: 30.sp,
                      width: 100.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            height: 20.sp,
                            width: 40.sp,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  4.sp,
                                ),
                                color: Color(0x5effffff)),
                            child: Obx(() {
                              return Text(
                                '${indexController.currentIndex.value + 1}/${storyItems.length}',
                                style: TextStyle(
                                  color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                                ),
                              );
                            }),
                          ),
                          PopupMenuButton(
                            color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
                            onOpened: () {
                              controller.pause();
                            },
                            onCanceled: () {
                              controller.play();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            icon: Icon(
                              Icons.more_vert,
                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                            ),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                onTap: () {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Get.to(ReportScreen());
                                  });
                                },
                                child: Text(
                                  'Report',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffFF0000),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Block',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    Get.off(ChatScreen(
                                      userId: '',
                                    ));
                                  });
                                },
                                child: Text(
                                  'Message',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.sp,
                  bottom: 90.sp,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.off(SeeViewersScreen());
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/svgs/view.svg'),
                            Obx(() {
                              return Text(
                                (widget.storiesList[indexController.currentIndex.value].views ?? 0).toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset('assets/svgs/like.svg'),
                          Obx(() {
                            return Text(
                              (widget.storiesList[indexController.currentIndex.value].likes?.length ?? 0).toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(CommentsScreen(
                            postId: widget.storiesList[indexController.currentIndex.value].id.toString(),
                          ));
                          controller.pause();
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/svgs/comment.svg'),
                            Text(
                              '1.5k',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            _controller.toggle();
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 40.sp),
            child: FloatingActionButton(
              onPressed: () {
                if (_controller.isPanelOpen == false) {
                  _controller.open();

                  controller.pause();
                } else if (_controller.isPanelOpen == true) {
                  _controller.close();
                  controller.play();
                }
              },
              child: Icon(
                Icons.keyboard_arrow_down,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                size: 30.sp,
              ),
              backgroundColor: Color(0x5effffff),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListPanel() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(10.sp),
            leading: Container(
              padding: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.sp,
                    color: Color(0xff2A70C8),
                  )),
              child: CircleAvatar(
                radius: 20.sp,
                backgroundImage: ExtendedNetworkImageProvider(
                  "$domainUrlWithProtocol${widget.userImage}",
                ),
              ),
            ),
            title: Text(
              widget.username,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
              ),
            ),
            trailing: Icon(
              Icons.more_vert,
              color: Color(0xff97A1B4),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: ReadMoreText(
                text: '''${widget.storiesList[indexController.currentIndex.value].caption}${" " * 250}''',
                maxLength: 250,
              ),
            ),
          ),
        ],
      );

  Widget _buildGridList() => Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: StoryView(
                storyItems: storyItems,
                controller: controller,
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.pop(context);
                  }
                  if (direction == Direction.up) {
                    storyItems.clear();
                    initi();
                  }
                },
                onStoryShow: (item) {},
                onComplete: () {
                  Navigator.pop(context);
                },
                indicatorColor: Colors.white,
              ),
            ),
            Positioned(
              top: 10.sp,
              left: 0,
              right: 0,
              child: ListTile(
                contentPadding: EdgeInsets.only(right: 0, left: 10.sp),
                leading: Container(
                  padding: EdgeInsets.all(2.sp),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.sp,
                        color: ThemeService.isSavedDarkMode() ? Colors.black : Colors.white,
                      )),
                  child: CircleAvatar(
                    radius: 20.sp,
                    backgroundImage: ExtendedNetworkImageProvider("$domainUrlWithProtocol${widget.userImage}"),
                  ),
                ),
                title: Text(
                  widget.username,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                  ),
                ),
                subtitle: Obx(() {
                  return RichText(
                    text: TextSpan(
                        text: 'Good Football   ',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: widget.storiesList[indexController.currentIndex.value].timestamp.toRelativeTimeShort,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                            ),
                          ),
                        ]),
                  );
                }),
                trailing: Container(
                  height: 30.sp,
                  width: 100.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.sp),
                        height: 20.sp,
                        width: 40.sp,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              4.sp,
                            ),
                            color: Color(0x5effffff)),
                        child: Obx(() {
                          return Text(
                            '${indexController.currentIndex.value + 1}/${storyItems.length}',
                            style: TextStyle(
                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                            ),
                          );
                        }),
                      ),
                      PopupMenuButton(
                        color: ThemeService.isSavedDarkMode() ? Color(0xff3D3D3D) : Colors.white,
                        onOpened: () {
                          controller.pause();
                        },
                        onCanceled: () {
                          controller.play();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        icon: Icon(
                          Icons.more_vert,
                          color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                        ),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Get.to(ReportScreen());
                              });
                            },
                            child: Text(
                              'Report',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFF0000),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              'Block',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Get.off(ChatScreen(
                                  userId: '',
                                ));
                              });
                            },
                            child: Text(
                              'Message',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Share',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10.sp,
              bottom: 90.sp,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.off(SeeViewersScreen());
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/svgs/view.svg'),
                        Obx(() {
                          return Text(
                            (widget.storiesList[indexController.currentIndex.value].views ?? 0).toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/svgs/like.svg'),
                      Obx(() {
                        return Text(
                          (widget.storiesList[indexController.currentIndex.value].likes?.length ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.to(CommentsScreen(
                      //   COntroller: controller,
                      // ));
                      controller.pause();
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/svgs/comment.svg'),
                        Text(
                          '1.5k',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget ReadMoreText({
    required String text,
    required int maxLength,
  }) =>
      Column(
        children: [
          RichText(
            text: TextSpan(
              text: isExpanded ? text : text.substring(0, maxLength) + '...',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: ThemeService.isSavedDarkMode() ? Colors.white : Colors.black,
              ),
              children: [
                TextSpan(
                  text: isExpanded ? '' : 'more',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Color(0xff2A70C8)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(
                        StoryTextViewScreen(
                          strl: _controller,
                          username: widget.username,
                          userImage: '$domainUrlWithProtocol${widget.userImage}',
                          text: widget.storiesList[indexController.currentIndex.value].caption,
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
          Visibility(
            visible: isExpanded == false ? true : false,
            child: GestureDetector(
              onTap: () {
                Get.to(
                  StoryTextViewScreen(
                    strl: _controller,
                    username: widget.username,
                    userImage: '$domainUrlWithProtocol${widget.userImage}',
                    text: widget.storiesList[indexController.currentIndex.value].caption,
                  ),
                );
              },
              child: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: Color(
                  0xff79869F,
                ),
              ),
            ),
          ),
        ],
      );
}

class MyStoryController extends GetxController {
  var currentIndex = 0.obs;

  void updateViews(int id) async {
    var loginResponse = await LoginController.getLoginResponse();
    var data = LoginResponse.fromJson(jsonDecode(loginResponse ?? ""));

    var response = await http.get(
      Uri.parse('https://rollupp.co/post/updateviews/$id'),
      headers: {
        "Authorization": "Bearer ${data.accessToken}",
        "Content-Type": "application/json" // Set the content type to JSON
      },
    ).catchError((error) {
      showMessageSheet("Error", error.toString(), sheetType: BottomSheetType.error);
    });

    print(response.body);
  }
}
