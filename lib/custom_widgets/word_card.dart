import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordCard extends StatelessWidget {
  final String mainText;
  final String pinyin;
  final String meaning;
  final Function(BuildContext, String)? onWordTap;
  final Function(BuildContext, String)? onLongWordTap;

  const WordCard({
    super.key,
    required this.mainText,
    required this.pinyin,
    required this.meaning,
    this.onWordTap,
    this.onLongWordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.indigo,
              )
          )
      ),
      padding: EdgeInsets.fromLTRB(0.h, 5.h, 15.h, 5.h),
      child: Row(
        children: [
          GestureDetector(
            onLongPress: () {
              if (onLongWordTap != null) {
                onLongWordTap!(context, mainText);
              }
            },
            onTap: () {
              if (onWordTap != null) {
                onWordTap!(context, mainText);
              }
            },
            child: Container(
                height: 50.h,
                width: 100.w,
                alignment: Alignment.center,
                child: Text(mainText, style: TextStyle(fontSize: 26.sp))
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 25.h, child: Text(pinyin, style: TextStyle(fontSize: 15.sp))),
                SizedBox(height: 25.h,child: Text(meaning, style: TextStyle(fontSize: 12.sp))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
