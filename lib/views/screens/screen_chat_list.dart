import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paulineife_user/views/screens/screen_chat.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_input_field1.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: CustomInputField1(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xffE2E4EB),
              suffix: Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
              hint: 'Search',
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DMSansR',
                  color: Color(0xff79869F)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              'Search Result',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                  fontFamily: 'DMSansR'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: (){Get.to(ChatScreen());},
                  leading: CircleAvatar(
                    radius: 25.sp,
                    backgroundImage: AssetImage(
                        'assets/images/12.png'),
                  ),
                  title: Text(
                    'Asad',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000),
                        fontFamily: 'DMSansR'),
                  ),
                  subtitle: Text(
                    'Hi, Asad how are you',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff79869F),
                        fontFamily: 'DMSansR'),
                  ),
                  trailing: Badge(
                    label: Text('1'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}