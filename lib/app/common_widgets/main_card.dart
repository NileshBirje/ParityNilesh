import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_nilesh/app/constants/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCard extends StatefulWidget {
  final String image;
  final String title;
  final String likeCount;
  final String commentCount;
  final String date;
  const MainCard(
      {super.key,
      required this.image,
      required this.title,
      required this.likeCount,
      required this.commentCount,
      required this.date});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Style.whiteCol,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 30.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.r),
                        ),
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 30.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
                          ),
                          image: DecorationImage(image: imageProvider)),
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Text(
                    widget.title,
                    style: Style.regularText,
                  ))
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20.w,
              ),
              const Icon(
                Icons.thumb_up_alt,
                color: Style.greyCol,
              ),
              Text(
                widget.likeCount,
                style: Style.lightText,
              ),
              SizedBox(
                width: 20.w,
              ),
              const Icon(
                Icons.comment_rounded,
                color: Style.greyCol,
              ),
              Text(
                widget.commentCount,
                style: Style.lightText,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                widget.date,
                style: Style.lightText,
              ),
            ],
          )
        ],
      ),
    );
  }
}
