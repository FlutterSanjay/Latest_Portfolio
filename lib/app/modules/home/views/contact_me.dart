import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/controllers/home_controller.dart';
import '../../../../utils/app_colors.dart';
import 'section_header.dart';

class ContactMe extends GetView<HomeController> {
  const ContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;

    return Container(
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.w : 80.w,
        vertical: isMobile ? 60.h : 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionHeader(
            tag: 'CONTACT',
            title: 'contact_title'.tr,
            subtitle: 'contact_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          isMobile ? _mobileLayout(context) : _desktopLayout(context),
        ],
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _contactInfo(context)),
        SizedBox(width: 48.w),
        Expanded(flex: 3, child: _contactForm(context)),
      ],
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return Column(
      children: [
        _contactInfo(context),
        SizedBox(height: 40.h),
        _contactForm(context),
      ],
    );
  }

  Widget _contactInfo(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'contact_heading'.tr,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: isMobile ? Get.width * 0.05 : 22.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 12.h),
        Text(
          'contact_desc'.tr,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isMobile ? Get.width * 0.033 : 14.sp,
            height: 1.7,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 36.h),

        // Contact cards
        _contactCard(
          icon: FontAwesomeIcons.locationDot,
          label: 'contact_loc'.tr,
          value: 'contact_loc_val'.tr,
          color: const Color(0xFF7C3AED),
          onTap: null,
          isMobile: isMobile,
        ),
        SizedBox(height: 14.h),
        _contactCard(
          icon: FontAwesomeIcons.envelope,
          label: 'contact_email'.tr,
          value: 'sanjayshaw80138@gmail.com',
          color: const Color(0xFF06B6D4),
          onTap: () =>
              controller.openUrl('mailto:sanjayshaw80138@gmail.com'),
          isMobile: isMobile,
        ),
        SizedBox(height: 14.h),
        _contactCard(
          icon: FontAwesomeIcons.phone,
          label: 'contact_phone'.tr,
          value: '+91 80138 12268',
          color: const Color(0xFF10B981),
          onTap: () => controller.openUrl('tel:+918013812268'),
          isMobile: isMobile,
        ),
        SizedBox(height: 14.h),
        _contactCard(
          icon: FontAwesomeIcons.linkedin,
          label: 'LinkedIn',
          value: 'sanjay-shaw-6a70a7178',
          color: const Color(0xFF0A66C2),
          onTap: () => controller.openUrl(
              'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/'),
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required VoidCallback? onTap,
    required bool isMobile,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 50.r : 16.r),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 18.r : 10.r),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: FaIcon(
                icon,
                color: color,
                size: isMobile ? Get.width * 0.042 : 16.sp,
              ),
            ),
            SizedBox(width: isMobile ? 30.w : 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: isMobile ? Get.width * 0.026 : 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    value,
                    style: TextStyle(
                      color: onTap != null
                          ? color
                          : AppColors.textColor,
                      fontSize: isMobile ? Get.width * 0.031 : 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textMuted,
                size: isMobile ? Get.width * 0.028 : 11.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _contactForm(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 55.r : 28.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'contact_form_title'.tr,
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: isMobile ? Get.width * 0.042 : 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: isMobile ? 30.h : 24.h),
          _field('contact_name'.tr, controller.nameController, isMobile),
          SizedBox(height: isMobile ? 22.h : 16.h),
          _field('contact_email_field'.tr, controller.emailController, isMobile),
          SizedBox(height: isMobile ? 22.h : 16.h),
          _field('contact_subject'.tr, controller.subjectController, isMobile),
          SizedBox(height: isMobile ? 22.h : 16.h),
          _field('contact_msg'.tr, controller.messageController, isMobile,
              maxLines: 5),
          SizedBox(height: isMobile ? 30.h : 24.h),
          // Send button
          Obx(() => GestureDetector(
                onTap: controller.isSendingMessage.value
                    ? null
                    : () => controller.sendMessage(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: isMobile ? 18.h : 16.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: controller.isSendingMessage.value
                        ? null
                        : AppColors.primaryGradient,
                    color: controller.isSendingMessage.value
                        ? AppColors.cardHoverColor
                        : null,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: controller.isSendingMessage.value
                        ? []
                        : [
                            BoxShadow(
                              color: AppColors.primaryColor
                                  .withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                  ),
                  child: Center(
                    child: controller.isSendingMessage.value
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.textSecondary,
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.send_rounded,
                                  color: Colors.white,
                                  size: isMobile
                                      ? Get.width * 0.038
                                      : 16.sp),
                              SizedBox(width: isMobile ? 16.w : 8.w),
                              Text(
                                'contact_send'.tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile
                                      ? Get.width * 0.036
                                      : 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _field(
    String hint,
    TextEditingController ctrl,
    bool isMobile, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: TextStyle(
        color: AppColors.textColor,
        fontSize: isMobile ? Get.width * 0.033 : 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.textMuted,
          fontSize: isMobile ? Get.width * 0.033 : 13.sp,
        ),
        filled: true,
        fillColor: AppColors.surfaceColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 50.w : 16.w,
          vertical: maxLines > 1
              ? isMobile
                  ? 40.h
                  : 14.h
              : isMobile
                  ? 18.h
                  : 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),
    );
  }
}
