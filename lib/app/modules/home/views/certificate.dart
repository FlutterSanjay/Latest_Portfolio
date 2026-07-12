import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'section_header.dart';

class Certifications extends StatelessWidget {
  const Certifications({super.key});

  void _openCertificate(String url) async {
    if (url.isEmpty) return;
    
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'cert_err'.tr,
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    final bool isTablet = 1.sw < 1200;

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
            tag: 'CERTIFICATIONS',
            title: 'cert_title'.tr,
            subtitle: 'cert_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          LayoutBuilder(
            builder: (ctx, constraints) {
              final crossAxisCount = isMobile ? 1 : isTablet ? 2 : 3;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 20.w : 24.w,
                  mainAxisSpacing: isMobile ? 20.h : 24.h,
                  childAspectRatio: isMobile ? 1.4 : isTablet ? 1.6 : 2.2,
                ),
                itemCount: _certifications.length,
                itemBuilder: (ctx, i) {
                  return _CertCard(
                    cert: _certifications[i],
                    isMobile: isMobile,
                    onTap: () =>
                        _openCertificate(_certifications[i]['link']!),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> get _certifications => [
    {
      'title_key': 'cert1_title',
      'issuer': 'Google & Udemy',
      'year': '2024',
      'icon': Icons.phone_android_rounded,
      'color': Color(0xFF54C5F8),
      'link':
          'https://drive.google.com/file/d/1X7yXdaVNXGFLT2iTJSseG17XAiLGlpO5/preview',
    },
    {
      'title_key': 'cert2_title',
      'issuer': 'Flutter Community',
      'year': '2024',
      'icon': Icons.extension_rounded,
      'color': Color(0xFF7C3AED),
      'link':
          'https://drive.google.com/file/d/1lWfR2xPrttjGaOVQpx7vckjM3DpkYoUV/preview',
    },
    {
      'title_key': 'cert3_title',
      'issuer': 'Apna College',
      'year': '2025',
      'icon': Icons.web_rounded,
      'color': Color(0xFF10B981),
      'link':
          'https://drive.google.com/file/d/1Zrgs2bCMOmnA4fUKgc00uo_NlX4GJyBm/preview',
    },
    {
      'title_key': 'cert4_title',
      'issuer': 'be10X',
      'year': '2025',
      'icon': Icons.smart_toy_rounded,
      'color': Color(0xFFF59E0B),
      'link':
          'https://drive.google.com/file/d/1Mkq4Ne8eisxRzW5CUJ2PZ09ROGHTJ34z/preview',
    },
    {
      'title_key': 'cert5_title',
      'issuer': 'Great Learning Academy',
      'year': '2024',
      'icon': Icons.design_services_rounded,
      'color': Color(0xFFEC4899),
      'link':
          'https://drive.google.com/file/d/1xMeVW3PrSzveUfxoJ8RZ6PblHTdXU5SE/preview',
    },
    {
      'title_key': 'cert6_title',
      'issuer': 'Udemy',
      'year': '2024',
      'icon': Icons.source_rounded,
      'color': Color(0xFF06B6D4),
      'link':
          'https://drive.google.com/file/d/1-srSE-l2aPNCKvQNUulE52G0Rcw8gpNi/preview',
    },
    {
      'title_key': 'cert7_title',
      'issuer': 'Inter University Level (Prof. A.K. Yadav & Prof. Harish Kumar)',
      'year': '2024',
      'icon': Icons.science_rounded,
      'color': Color(0xFF3B82F6),
      'link':
          'https://drive.google.com/file/d/1M3jnlhu2tffeCUHlk_nwaTRq6NjiFgkT/preview',
    },
    {
      'title_key': 'cert8_title',
      'issuer': 'Air Vice Marshal (L N Sharma)',
      'year': '2019',
      'icon': Icons.sports_kabaddi_rounded,
      'color': Color(0xFF10B981),
      'link': '',
    },
  ];
}

// ─── Certificate Card ─────────────────────────────────────────────────────────
class _CertCard extends StatefulWidget {
  final Map<String, dynamic> cert;
  final bool isMobile;
  final VoidCallback onTap;
  const _CertCard(
      {required this.cert, required this.isMobile, required this.onTap});

  @override
  State<_CertCard> createState() => _CertCardState();
}

class _CertCardState extends State<_CertCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.cert;
    final Color accent = c['color'] as Color;
    final bool isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4.0 : 0.0, 0),
          padding: EdgeInsets.all(isMobile ? 55.r : 18.r),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _hovered
                  ? accent.withValues(alpha: 0.5)
                  : AppColors.borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? accent.withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _hovered ? 24 : 6,
                offset: Offset(0, _hovered ? 10 : 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon + Year row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(isMobile ? 18.r : 10.r),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      c['icon'] as IconData,
                      color: accent,
                      size: isMobile ? Get.width * 0.055 : 22.sp,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16.w : 8.w,
                      vertical: isMobile ? 5.h : 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        color: accent.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      c['year'] as String,
                      style: TextStyle(
                        color: accent,
                        fontSize: isMobile ? Get.width * 0.026 : 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 16.h : 14.h),

              // Title
              Text(
                c['title_key'].toString().tr,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: isMobile ? Get.width * 0.038 : 14.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 4.h),

              // Issuer
              Text(
                c['issuer'] as String,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: isMobile ? Get.width * 0.028 : 11.sp,
                ),
              ),

              const Spacer(),

              // View button
              Row(
                children: [
                  Icon(
                    Icons.open_in_new_rounded,
                    size: isMobile ? Get.width * 0.03 : 12.sp,
                    color: _hovered ? accent : AppColors.textMuted,
                  ),
                  SizedBox(width: isMobile ? 10.w : 5.w),
                  Text(
                    'exp_view_cert'.tr,
                    style: TextStyle(
                      color: _hovered ? accent : AppColors.textMuted,
                      fontSize: isMobile ? Get.width * 0.028 : 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
