import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../utils/app_colors.dart';

class ContactMe extends GetView<HomeController> {
  const ContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = 1.sw < 800;

    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.w : 80.w,
        vertical: isMobile ? 40.h : 80.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Contact  ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.06 : 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Me',
                  style: TextStyle(
                    fontSize: isMobile ? Get.width * 0.06 : 48.sp,
                    fontWeight: FontWeight.bold,
                    foreground:
                    Paint()
                      ..shader = LinearGradient(
                        colors: [
                          AppColors.secondaryColor,
                          AppColors.secondary2Color,
                        ],
                      ).createShader(Rect.fromLTWH(0, 0, 300, 100)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: isMobile ? 150.w : 190.w,
            height: isMobile ? 2.h : 6.h,
            color: AppColors.secondaryColor,
            margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
          ),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Contact Information
              Expanded(
                flex: isMobile ? 0 : 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 40.h : 0.h, right: isMobile ? 0.h : 60.h),
                  child: Column(
                    crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      _buildContactInfo(
                        FontAwesomeIcons.locationDot,
                        'Location',
                        'Kolkata, West Bengal, India',
                        isMobile
                      ),
                      SizedBox(height: 30.h),
                      _buildContactInfo(
                        FontAwesomeIcons.envelope,
                        'Email',
                        'sanjayshaw80138@gmail.com',
                        isMobile,
                        onTap:
                            () => controller.openUrl(
                              'mailto:sanjayshaw80138@gmail.com',
                            ),
                      ),
                      SizedBox(height: 30.h),
                      _buildContactInfo(
                        FontAwesomeIcons.phone,
                        'Phone',
                        '+91 8013812268',
                        isMobile,
                        onTap: () => controller.openUrl('tel:+918013812268'),
                      ),
                      SizedBox(height: 30.h),
                      _buildContactInfo(
                        FontAwesomeIcons.linkedin,
                        'LinkedIn',
                        'Sanjay Shaw',
                        isMobile,
                        onTap:
                            () => controller.openUrl(
                              'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/',
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right side: Contact Form
              Expanded(
                flex: isMobile ? 0 : 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.h),
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 5),
                        blurRadius: 10.r,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildTextField('Your Name',controller.nameController, isMobile),
                      SizedBox(height: 30.h),
                      _buildTextField('Your Email',controller.emailController, isMobile),
                      SizedBox(height: 30.h),
                      _buildTextField('Subject', controller.subjectController,isMobile),
                      SizedBox(height: 30.h),
                      _buildTextField('Your Message',controller.messageController, isMobile, maxLines: 5),
                      SizedBox(height: 40.h),
                      ElevatedButton(
                        onPressed: () {
                          // Implement form submission logic here
                          controller.sendMessage();
                          Get.snackbar(
                            'Message Sent',
                            'Thank you for your message!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.secondaryColor,
                            colorText: AppColors.backgroundColor,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 30.w : 40.w,
                            vertical: 25.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Send Message',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: isMobile ? Get.width * 0.035 : 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String value, bool isMobile, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: isMobile ? 10.w : 14.w),
        child: Row(
          mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min, // To wrap content
          children: [
            FaIcon(icon, color: AppColors.primaryColor, size: isMobile ? Get.width * 0.035 : 30.sp),
            SizedBox(width: isMobile ? 40.w : 30.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textLightColor,
                    fontSize: isMobile ? Get.width * 0.025 : 27.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.025 : 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, bool isMobile, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textColor),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textLightColor),
        filled: true,
        fillColor: AppColors.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: maxLines > 1 ? 15.h : 10.h,
        ),
      ),
    );
  }
}
