import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Certifications extends StatelessWidget {
  const Certifications({super.key});

  void openCertificate(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open certificate");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = 1.sw < 800;
    final isTablet = 1.sw < 1000;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal:
            isMobile
                ? 16.sp
                : isTablet
                ? 40.sp
                : 80.sp,
        vertical: 40.sp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Section Title
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'My ',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? 28.sp : 48.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Certifications',
                  style: TextStyle(
                    fontSize: isMobile ? 28.sp : 48.sp,
                    fontWeight: FontWeight.bold,
                    foreground:
                        Paint()
                          ..shader = LinearGradient(
                            colors: [
                              AppColors.secondaryColor,
                              AppColors.secondary2Color,
                            ],
                          ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: isMobile ? 150.w : 190.w,
            height: 3.h,
            margin: EdgeInsets.only(top: 10.h, bottom: 40.h),
            color: AppColors.secondaryColor,
          ),

          /// Grid Layout
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount =
                  isMobile
                      ? 1
                      : isTablet
                      ? 2
                      : 3;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _certifications.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30.w,
                  mainAxisSpacing: 30.h,
                  childAspectRatio:
                      isMobile
                          ? 1.1
                          : isTablet
                          ? 1.2
                          : 2.2,
                ),
                itemBuilder: (context, index) {
                  final cert = _certifications[index];
                  return _buildCertificationCard(cert, isMobile);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationCard(Map<String, dynamic> cert, bool isMobile) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openCertificate(cert['link']),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(isMobile ? 20.h : 15.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15.r,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row
                Row(
                  children: [
                    Icon(
                      cert['icon'] as IconData,
                      color: AppColors.secondaryColor,
                      size: isMobile ? 32.sp : 40.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        cert['title'] ?? '',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: isMobile ? 18.sp : 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                /// Issuer & Year Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cert['issuer'] ?? '',
                      style: TextStyle(
                        color: AppColors.textLightColor,
                        fontSize: isMobile ? 14.sp : 18.sp,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        cert['year'] ?? '',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 12.sp : 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                /// View Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondaryColor,
                          AppColors.secondary2Color,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.link, color: Colors.white, size: 16),
                        SizedBox(width: 6.w),
                        Text(
                          'View Certificate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 12.sp : 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _certifications = [
    {
      'title': 'Flutter Development Bootcamp',
      'issuer': 'Google & Udemy',
      'year': '2024',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1X7yXdaVNXGFLT2iTJSseG17XAiLGlpO5/preview',
    },
    {
      'title': 'Flutter Puzzle Hack.',
      'issuer': 'Flutter Community',
      'year': '2024',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1lWfR2xPrttjGaOVQpx7vckjM3DpkYoUV/preview',
    },
    {
      'title': 'Full Stack Web Development',
      'issuer': 'Apna College',
      'year': '2025',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1Zrgs2bCMOmnA4fUKgc00uo_NlX4GJyBm/preview',
    },
    {
      'title': 'AI Tools Workshop',
      'issuer': 'be10X',
      'year': '2025',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1Mkq4Ne8eisxRzW5CUJ2PZ09ROGHTJ34z/preview',
    },
    {
      'title': 'Ui & UX for Beginners',
      'issuer': 'Great Learning Academy',
      'year': '2024',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1xMeVW3PrSzveUfxoJ8RZ6PblHTdXU5SE/preview',
    },
    {
      'title': 'Git & GitHub Mastery',
      'issuer': 'Udemy',
      'year': '2024',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1-srSE-l2aPNCKvQNUulE52G0Rcw8gpNi/preview',
    },
    {
      'title': 'National Science Day',
      'issuer': 'Central University of Haryana',
      'year': '2024',
      'icon': Icons.workspace_premium,
      'link':
          'https://drive.google.com/file/d/1M3jnlhu2tffeCUHlk_nwaTRq6NjiFgkT/preview',
    },
  ];
}
