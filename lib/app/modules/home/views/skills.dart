import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:get/get.dart';
import 'section_header.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    final bool isMobile = 1.sw < 800;
    final bool isTablet = 1.sw < 1200;

    return Container(
      color: AppColors.surfaceColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.w : 80.w,
        vertical: isMobile ? 60.h : 100.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SectionHeader(
            tag: 'SKILLS',
            title: 'skills_title'.tr,
            subtitle: 'skills_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 48.h : 64.h),
          // Grid
          LayoutBuilder(
            builder: (ctx, constraints) {
              final crossAxisCount = isMobile ? 1 : isTablet ? 2 : 4;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 16.w : 20.w,
                  mainAxisSpacing: isMobile ? 16.h : 20.h,
                  childAspectRatio: isMobile ? 1.3 : isTablet ? 1.25 : 0.82,
                ),
                itemCount: _skillCategories.length,
                itemBuilder: (ctx, i) {
                  final cat = _skillCategories[i];
                  return _SkillCard(
                    title: cat['title'] as String,
                    icon: cat['icon'] as IconData,
                    color: cat['color'] as Color,
                    skills: cat['skills'] as List<Map<String, dynamic>>,
                    isMobile: isMobile,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> get _skillCategories => [
    {
      'title': 'skill_cat_1'.tr,
      'icon': FontAwesomeIcons.code,
      'color': Color(0xFF06B6D4),
      'skills': [
        {'name': 'Dart', 'level': 90},
        {'name': 'C++', 'level': 85},
        {'name': 'JavaScript', 'level': 90},
      ],
    },
    {
      'title': 'skill_cat_2'.tr,
      'icon': FontAwesomeIcons.layerGroup,
      'color': Color(0xFF10B981),
      'skills': [
        {'name': 'Flutter', 'level': 90},
        {'name': 'Node.js & Express.js', 'level': 85},
        {'name': 'React Js & DaisyUI', 'level': 80},
        {'name': 'TanStack & Prisma ORM', 'level': 80},
      ],
    },
    {
      'title': 'skill_cat_3'.tr,
      'icon': FontAwesomeIcons.database,
      'color': Color(0xFFEC4899),
      'skills': [
        {'name': 'MongoDB', 'level': 85},
        {'name': 'MySQL', 'level': 80},
        {'name': 'SQFLite', 'level': 85},
        {'name': 'Firebase', 'level': 90},
      ],
    },
    {
      'title': 'skill_cat_4'.tr,
      'icon': FontAwesomeIcons.robot,
      'color': Color(0xFF8B5CF6),
      'skills': [
        {'name': 'LLMs', 'level': 85},
        {'name': 'LangChain', 'level': 80},
        {'name': 'Hugging Face', 'level': 75},
      ],
    },
    {
      'title': 'skill_cat_5'.tr,
      'icon': FontAwesomeIcons.codeBranch,
      'color': Color(0xFFF59E0B),
      'skills': [
        {'name': 'GetX', 'level': 95},
        {'name': 'BloC', 'level': 85},
        {'name': 'Provider', 'level': 90},
      ],
    },
    {
      'title': 'skill_cat_6'.tr,
      'icon': FontAwesomeIcons.screwdriverWrench,
      'color': Color(0xFF3B82F6),
      'skills': [
        {'name': 'Git/GitHub & Actions', 'level': 90},
        {'name': 'Docker', 'level': 80},
        {'name': 'Postman & Requestly', 'level': 85},
        {'name': 'FlutterFlow & Figma', 'level': 85},
      ],
    },
  ];
}

// ─── Skill Card ───────────────────────────────────────────────────────────────
class _SkillCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Map<String, dynamic>> skills;
  final bool isMobile;

  const _SkillCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
    required this.isMobile,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _animController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fillAnimation =
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic);
    // Delay then animate bars
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(widget.isMobile ? 60.r : 20.r),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _hovered
                ? widget.color.withValues(alpha: 0.4)
                : AppColors.borderColor,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(widget.isMobile ? 18.r : 9.r),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: FaIcon(
                    widget.icon,
                    color: widget.color,
                    size: widget.isMobile ? Get.width * 0.05 : 18.sp,
                  ),
                ),
                SizedBox(width: widget.isMobile ? 24.w : 12.w),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize:
                          widget.isMobile ? Get.width * 0.04 : 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: widget.isMobile ? 20.h : 18.h),
            // Skill bars
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.skills.map((s) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              s['name']!,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: widget.isMobile
                                    ? Get.width * 0.029
                                    : 12.sp,
                              ),
                            ),
                            Text(
                              '${s['level']}%',
                              style: TextStyle(
                                color: widget.color,
                                fontSize: widget.isMobile
                                    ? Get.width * 0.028
                                    : 11.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        AnimatedBuilder(
                          animation: _fillAnimation,
                          builder: (_, __) {
                            return Container(
                              height: widget.isMobile ? 5.h : 5.h,
                              decoration: BoxDecoration(
                                color: AppColors.borderColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _fillAnimation.value *
                                    (s['level']! / 100),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.color,
                                        widget.color
                                            .withValues(alpha: 0.7),
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.color
                                            .withValues(alpha: 0.5),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}