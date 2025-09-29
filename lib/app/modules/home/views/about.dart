import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';

class About extends GetView<HomeController> {
  const About({super.key});

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
                  text: 'About ',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Image/Illustration
              Expanded(
                flex: isMobile ? 0 : 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isMobile ? 30.h : 0.h,
                    right: isMobile ? 0.h : 50.h,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 1600),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(
                          top: controller.isMoveUp.value ? 0.h : 20.h,
                        ),
                        width:
                            isMobile
                                ? MediaQuery.of(context).size.width * 0.75
                                : 320.w,
                        height:
                            isMobile
                                ? MediaQuery.of(context).size.width * 0.5
                                : 670.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          // border: Border.all(
                          //   color: Colors.grey.shade600,
                          //   width: 2,
                          // ),
                        ),
                        clipBehavior:
                            Clip.hardEdge, // makes image respect border radius
                        child: Image.asset(
                          'images/My_Photo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.cardColor,
                              child: Center(
                                child: Text(
                                  'Image Not Found',
                                  style: TextStyle(
                                    color: AppColors.textLightColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Right side: Text content and stats
              Expanded(
                flex: isMobile ? 0 : 3,
                child: Column(
                  crossAxisAlignment:
                      isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I'm Sanjay Shaw, a Flutter Developer",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: isMobile ? Get.width * 0.04 : 44.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "As a Computer Science and Engineering student, I am passionate about creating responsive, user-friendly, and scalable applications. I specialize in Flutter & React Native development, with strong knowledge of Flutter Flow, Dart, Python, and C++. My experience extends to full-stack development using Node.js, Express.js, REST APIs, and database management with Google Cloud Firestore, MongoDB, and MySQL.I also bring expertise in state management (GetX, BLoC), along with UI/UX design in Figma, ensuring both functionality and great user experience. Through my projects and internship experience, I have developed a strong foundation in problem-solving, teamwork, and precision in execution. With a continuous learning mindset, I aim to contribute effectively as a mobile and web app developer while growing with industry advancements.",
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      
                      "I'm passionate about building elegant solutions that solve real-world problems. My goal is to continue growing as a developer by taking on challenging projects and expanding my technical expertise.",
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? Get.width * 0.035 : 25.sp,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    SizedBox(height: 40.h),
                    // Stats (e.g., 4+ projects, 2 years experience)
                    Wrap(
                      spacing: 50.w,
                      runSpacing: 20.h,
                      alignment:
                          isMobile ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        _buildStatCard(context, '4+', 'Projects'),
                        _buildStatCard(context, '2+', 'Internships'),
                        _buildStatCard(context, '3+', 'Certificates'),
                        // Add more stats as needed
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String count, String label) {
    bool isMobile = 1.sw < 800; // Smaller breakpoint for cards
    Color cardColor = AppColors.cardColor; // Default color
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter:
              (_) => setState(
                () => cardColor = const Color.fromARGB(255, 66, 64, 66),
              ),
          onExit: (_) => setState(() => cardColor = AppColors.cardColor),
          child: Container(
            width: isMobile ? Get.width * 0.5 : 300.w,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10.r,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  count,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: isMobile ? Get.width * 0.05 : 60.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.04 : 40.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
