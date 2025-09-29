import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/app_colors.dart';

class Footer extends GetView<HomeController> {
  const Footer({super.key});

  // Helper method to create quick link items
  Widget _quickLink(String title, bool isMobile) {
    return TextButton(
      onPressed: () {
        controller.scrollToSection(title);
      },
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textLightColor,
          fontSize: isMobile ? Get.width * 0.035 : 25.sp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = 1.sw < 800;

    return Container(
      color: AppColors.cardColor, // Slightly different background for footer
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.sp : 80.sp,
        vertical: isMobile ? 40.sp : 60.sp,
      ),
      child: Column(
        children: [
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              // Left Section: Portfolio Info and Socials
              Expanded(
                flex: isMobile ? 0 : 2,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sanjay Shaw',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: isMobile ? Get.width * 0.06 : 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'A passionate Flutter and Web Developer specializing in creating beautiful, functional, and user-friendly applications.',
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed:
                              () => controller.openUrl(
                                'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/',
                              ),
                          icon: FaIcon(FontAwesomeIcons.linkedinIn, color: AppColors.socialIconColor, size: isMobile ? Get.width * 0.035 : 30.sp),
                        ),
                        SizedBox(width: 20.w),
                        IconButton(
                          onPressed:
                              () => controller.openUrl(
                                'https://github.com/FlutterSanjay',
                              ),
                          icon: FaIcon(FontAwesomeIcons.github, color: AppColors.socialIconColor, size: isMobile ? Get.width * 0.035 :30.sp),
                        ),
                        SizedBox(width: 20.w),
                        IconButton(
                          onPressed:
                              () => controller.openUrl(
                                'mailto:sanjayshaw80138@gmail.com',
                              ),
                          icon: FaIcon(FontAwesomeIcons.envelope, color: AppColors.socialIconColor, size: isMobile ? Get.width * 0.035 :30.sp),
                        ),
                        SizedBox(width: 20.w),
                        IconButton(
                          onPressed:
                              () => controller.openUrl(
                                'https://leetcode.com/u/sanjayshaw80138/',
                              ),
                          icon: FaIcon(FontAwesomeIcons.code, color: AppColors.socialIconColor, size: isMobile ? Get.width * 0.035 :30.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isMobile) SizedBox(width: 60.w),
              if(isMobile)Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Middle Section: Quick Links
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMobile) SizedBox(height: 40.h),
                        Text(
                          'Quick Links',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: isMobile ? Get.width * 0.035 : 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        Container(
                          width: isMobile ? 160.w : 120.w,
                          height: 5.h,
                          color: AppColors.secondaryColor,
                          margin: EdgeInsets.only(top: 10.h, bottom: isMobile ? 20.h : 15.h),
                        ),
                        _quickLink('Home',isMobile),
                        _quickLink('About',isMobile),
                        _quickLink('Skills',isMobile),
                        _quickLink('Experience',isMobile),
                        _quickLink('Projects',isMobile),
                        _quickLink('Education',isMobile),
                        _quickLink('Contact',isMobile),
                      ],
                    ),
                  ),
                  // Right Section: Languages
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        if (isMobile) SizedBox(height: 40.h),
                        Text(
                          'Languages',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: isMobile ? Get.width * 0.035 : 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        Container(
                          width: isMobile ? 60.h : 80.h,
                          height: 5.h,
                          color: AppColors.secondaryColor,
                          margin: EdgeInsets.only(top: 10.h, bottom: isMobile ? 20.h : 15.h),
                        ),
                        Text(
                          'English',
                          style: TextStyle(
                            color: AppColors.textLightColor,
                            fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Hindi',
                          style: TextStyle(
                            color: AppColors.textLightColor,
                            fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              )else
                Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile) SizedBox(height: 40.h),
                    Text(
                      'Quick Links',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: isMobile ? Get.width * 0.035 : 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    Container(
                      width: isMobile ? Get.width*0.3 : 120.w,
                      height: 5.h,
                      color: AppColors.secondaryColor,
                      margin: EdgeInsets.only(top: 10.h, bottom: isMobile ? 20.h : 15.h),
                    ),
                    _quickLink('Home',isMobile),
                    _quickLink('About',isMobile),
                    _quickLink('Skills',isMobile),
                    _quickLink('Experience',isMobile),
                    _quickLink('Projects',isMobile),
                    _quickLink('Education',isMobile),
                    _quickLink('Contact',isMobile),
                  ],
                ),
              ),
              if (!isMobile) SizedBox(width: 60.w),
              // Right Section: Languages
              if(!isMobile)Expanded(
                flex: isMobile ? 0 : 1,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    if (isMobile) SizedBox(height: 40.h),
                    Text(
                      'Languages',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: isMobile ? Get.width * 0.035 : 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    Container(
                      width: isMobile ? 60.h : 80.h,
                      height: 5.h,
                      color: AppColors.secondaryColor,
                      margin: EdgeInsets.only(top: 10.h, bottom: isMobile ? 20.h : 15.h),
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Hindi',
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                  ],
                ),
              ),

            ],
          ),
          Divider(color: AppColors.textLightColor, height: 80.h),
          Text(
            '© 2024 Sanjay Shaw. All rights reserved.',
            style: TextStyle(
              color: AppColors.textLightColor,
              fontSize: isMobile ? Get.width * 0.035 : 20.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
