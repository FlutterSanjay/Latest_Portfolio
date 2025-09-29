import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:portfolio/app/modules/home/views/contact_me.dart';
import 'package:portfolio/app/modules/home/views/projects.dart';
import 'package:portfolio/app/modules/home/views/skills.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';
import 'about.dart';
import 'education.dart';
import 'experience.dart';
import 'footer.dart';
import 'nav_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // Determine if it's a mobile layout based on screen width
    bool isMobile = 1.sw < 800;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // Use the custom AppBar for desktop and a Drawer for mobile
      appBar:
          isMobile
              ? AppBar(
                backgroundColor: AppColors.backgroundColor,
                title: RichText(
                  text: TextSpan(
                    text: 'Portfolio',
                    style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..shader = LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.primary4Color,
                                AppColors.primary5Color,
                              ],
                            ).createShader(Rect.fromLTWH(0, 0, 300, 100)),
                    ),
                  ),
                ),
                centerTitle: false,
                actions: [
                  Builder(
                    builder:
                        (context) => IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: AppColors.textColor,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        ),
                  ),
                ],
              )
              : null, // No AppBar for desktop, NavBar will be part of the body
      endDrawer: isMobile ? const MobileDrawer() : null, // Mobile drawer
      body: SingleChildScrollView(
        controller: controller.scrollController, // Assign the scroll controller
        child: Column(
          children: [
            // Desktop Navbar
            if (!isMobile) const NavBar(),
            // Hero Section
            Container(
              key: controller.homeKey, // Assign GlobalKey
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20.w : 80.w,
                vertical: isMobile ? 10.h : 80.h,
              ),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  // Left side: Text content and buttons
                  Expanded(
                    flex: isMobile ? 0 : 3,
                    child: Column(
                      crossAxisAlignment:
                          isMobile
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, I'm",
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: isMobile ? Get.width * 0.05 : 38.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(height: 30.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Sanjay ",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: isMobile ? Get.width * 0.08 : 85.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "Shaw",
                                style: TextStyle(
                                  fontSize: isMobile ? Get.width * 0.08 : 85.sp,
                                  fontWeight: FontWeight.bold,
                                  foreground:
                                      Paint()
                                        ..shader = LinearGradient(
                                          colors: [
                                            AppColors.primaryColor,
                                            AppColors.primary2Color,
                                            AppColors.primary3Color,
                                            AppColors.primary4Color,
                                            AppColors.primary5Color,
                                          ],
                                        ).createShader(
                                          Rect.fromLTWH(0, 0, 300, 100),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(height: 30.w),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: isMobile ? Get.width * 0.055 : 45.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                          child: AnimatedTextKit(
                            pause: Duration(milliseconds: 300),
                            animatedTexts: [
                              TyperAnimatedText(
                                "Flutter Developer",
                                speed: Duration(milliseconds: 200),
                              ),
                              TyperAnimatedText(
                                "Backend Developer",
                                speed: Duration(milliseconds: 200),
                              ),
                              TyperAnimatedText(
                                "Full Stack Developer",
                                speed: Duration(milliseconds: 200),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.w),
                        Text(
                          "A passionate Computer Science Engineering student with expertise in App development using Flutter, React & Node.js (Backend)",
                          style: TextStyle(
                            color: AppColors.textLightColor,
                            fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(height: isMobile ? 75.w : 40.h),
                        // Action Buttons
                        Wrap(
                          spacing: 30.w,
                          runSpacing: 30.h,
                          alignment:
                              isMobile
                                  ? WrapAlignment.center
                                  : WrapAlignment.start,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                controller.downloadPdf(
                                  'https://drive.google.com/uc?export=download&id=1WzVT7NVv6IB5zAwo4FylsHRq-3bnBFdk',
                                  'My_Resume',
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.primary2Color,
                                  width: 2.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 25.w : 38.h,
                                  vertical: isMobile ? 10.h : 24.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Download Resume',
                                style: TextStyle(
                                  color: AppColors.primary2Color,
                                  fontSize: isMobile ? 50.sp : 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                
                                controller.scrollToSection('Projects');
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColors.buttonBorderColor,
                                  width: 2.w,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 25.w : 38.h,
                                  vertical: isMobile ? 10.h : 24.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'View Projects',
                                style: TextStyle(
                                  color: AppColors.buttonBorderColor,
                                  fontSize: isMobile ? 50.sp : 25.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isMobile ? 40.w : 55.h),
                        // Social Media Icons
                        Row(
                          mainAxisAlignment:
                              isMobile
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed:
                                  () => controller.openUrl(
                                    'https://www.linkedin.com/in/sanjay-shaw-6a70a7178/',
                                  ),
                              icon: FaIcon(
                                FontAwesomeIcons.linkedinIn,
                                color: AppColors.socialIconColor,
                                size: isMobile ? Get.width * 0.06 : 40.sp,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            IconButton(
                              onPressed:
                                  () => controller.openUrl(
                                    'https://github.com/FlutterSanjay',
                                  ),
                              icon: FaIcon(
                                FontAwesomeIcons.github,
                                color: AppColors.socialIconColor,
                                size: isMobile ? Get.width * 0.06 : 40.sp,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            IconButton(
                              onPressed:
                                  () => controller.openUrl(
                                    'mailto:sanjayshaw80138@gmail.com',
                                  ),
                              icon: FaIcon(
                                FontAwesomeIcons.envelope,
                                color: AppColors.socialIconColor,
                                size: isMobile ? Get.width * 0.06 : 40.sp,
                              ),
                            ),
                            SizedBox(width: 20.w),
                            IconButton(
                              onPressed:
                                  () => controller.openUrl(
                                    'https://leetcode.com/u/sanjayshaw80138/',
                                  ), // Replace with actual blog/website
                              icon: FaIcon(
                                FontAwesomeIcons.code,
                                color: AppColors.socialIconColor,
                                size: isMobile ? Get.width * 0.06 : 40.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right side: Image
                  if (!isMobile) SizedBox(width: 40.w),
                  Expanded(
                    flex: isMobile ? 0 : 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 40.h : 0.h),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 1600),
                              curve: Curves.easeInOut,
                              margin: EdgeInsets.only(
                                top: controller.isMoveUp.value ? 0 : 20,
                              ),
                              width:
                                  isMobile
                                      ? MediaQuery.of(context).size.width * 0.75
                                      : 900.w,
                              height:
                                  isMobile
                                      ? MediaQuery.of(context).size.width * 0.5
                                      : 480.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey.shade600,
                                  width: 2,
                                ),
                              ),
                              clipBehavior:
                                  Clip.hardEdge, // makes image respect border radius
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: Get.height * 0.6,
                                  autoPlay: true,
                                ),

                                items:
                                    controller.sliderImage.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 5.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                            ),
                                            child: Image.asset(
                                              i,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Container(
                                                  color: AppColors.cardColor,
                                                  child: Center(
                                                    child: Text(
                                                      'Image Not Found',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors
                                                                .textLightColor,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // About Section
            SizedBox(key: controller.aboutKey, child: const About()),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // Skills Section
            SizedBox(key: controller.skillsKey, child: const Skills()),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // Experience Section
            SizedBox(key: controller.experienceKey, child: const Experience()),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // Projects Section
            SizedBox(key: controller.projectsKey, child: const Projects()),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // Education Section
            SizedBox(key: controller.educationKey, child: const Education()),
            if (isMobile) SizedBox(height: Get.height * 0.05),
            // Contact Section
            SizedBox(key: controller.contactKey, child: const ContactMe()),
            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
