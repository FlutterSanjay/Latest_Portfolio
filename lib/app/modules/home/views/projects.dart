import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/home_controller.dart';
import 'section_header.dart';

class Projects extends GetView<HomeController> {
  const Projects({super.key});

  // ─── Featured Projects (static, always shown) ────────────────────────────────
  static List<Map<String, dynamic>> get _featured => [
    {
      'title': 'Polluxa CRM',
      'desc_key': 'proj1_desc',
      'category': 'Flutter',
      'accent': Color(0xFF7C3AED),
      'icon': Icons.business_center_rounded,
      'link': 'https://play.google.com/store/apps/details?id=com.polluxa.salescrm&hl=en-US',
      'tech': ['Flutter', 'Firebase', 'GetX', 'Google Sign-In', 'Workmanager'],
    },
    {
      'title': 'Remote Interview Platform',
      'desc_key': 'proj2_desc',
      'category': 'Web Development',
      'accent': Color(0xFF06B6D4),
      'icon': Icons.videocam_rounded,
      'link': 'https://remote-interview-platform-xwwk.onrender.com/',
      'tech': ['React', 'TailwindCSS', 'Node.js', 'Express', 'MongoDB'],
    },
    {
      'title': 'Footware Store – E-Commerce App',
      'desc_key': 'proj3_desc',
      'category': 'Flutter',
      'accent': Color(0xFF10B981),
      'icon': Icons.shopping_bag_rounded,
      'link': 'https://github.com/FlutterSanjay/Footware_App',
      'tech': ['Flutter', 'Dart', 'Firebase', 'GetX', 'MVC'],
    },
  ];

  static const List<String> _categories = [
    'All',
    'AI',
    'Flutter',
    'Web Development',
  ];

  // ─── Language color map ───────────────────────────────────────────────────────
  static Color _langColor(String? lang) {
    switch (lang) {
      case 'Dart':
        return const Color(0xFF00B4AB);
      case 'JavaScript':
        return const Color(0xFFF1E05A);
      case 'TypeScript':
        return const Color(0xFF3178C6);
      case 'Python':
        return const Color(0xFF3572A5);
      case 'Kotlin':
        return const Color(0xFFA97BFF);
      case 'Swift':
        return const Color(0xFFF05138);
      case 'HTML':
        return const Color(0xFFE34C26);
      case 'CSS':
        return const Color(0xFF563D7C);
      case 'Go':
        return const Color(0xFF00ADD8);
      case 'Rust':
        return const Color(0xFFDEA584);
      case 'C++':
        return const Color(0xFFF34B7D);
      case 'C':
        return const Color(0xFF555555);
      default:
        return const Color(0xFF64748B);
    }
  }

  static String _timeAgo(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final dt = DateTime.parse(isoDate);
      final diff = DateTime.now().difference(dt);
      if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
      if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      return 'recently';
    } catch (_) {
      return '';
    }
  }

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
            tag: 'PROJECTS',
            title: 'proj_title'.tr,
            subtitle: 'proj_subtitle'.tr,
          ),
          SizedBox(height: isMobile ? 36.h : 48.h),

          // ── Category filter tabs ───────────────────────────────────────────
          Obx(() {
            return Wrap(
              spacing: isMobile ? 20.w : 10.w,
              runSpacing: 10.h,
              alignment: WrapAlignment.center,
              children: _categories.map((cat) {
                final bool sel = controller.selectedCategory.value == cat;
                return GestureDetector(
                  onTap: () => controller.selectedCategory.value = cat,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 30.w : 18.w,
                      vertical: isMobile ? 10.h : 9.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: sel ? AppColors.primaryGradient : null,
                      color: sel ? null : AppColors.cardColor,
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(
                        color: sel ? Colors.transparent : AppColors.borderColor,
                        width: 1,
                      ),
                      boxShadow: sel
                          ? [
                              BoxShadow(
                                color: AppColors.primaryColor
                                    .withValues(alpha: 0.35),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        color:
                            sel ? Colors.white : AppColors.textSecondary,
                        fontSize: isMobile ? Get.width * 0.032 : 13.sp,
                        fontWeight:
                            sel ? FontWeight.w600 : FontWeight.w400,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }),

          SizedBox(height: isMobile ? 36.h : 48.h),

          // ── Featured projects grid ─────────────────────────────────────────
          Obx(() {
            final sel = controller.selectedCategory.value;
            final filtered = sel == 'All'
                ? _featured
                : _featured.where((p) => p['category'] == sel).toList();

            if (filtered.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Text(
                  'proj_no_featured'.tr,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: isMobile ? Get.width * 0.035 : 14.sp,
                  ),
                ),
              );
            }

            final crossAxis = isMobile ? 1 : isTablet ? 2 : 3;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxis,
                crossAxisSpacing: isMobile ? 20.w : 24.w,
                mainAxisSpacing: isMobile ? 20.h : 24.h,
                mainAxisExtent: isMobile ? 380.h : 360.h,
              ),
              itemCount: filtered.length,
              itemBuilder: (ctx, i) =>
                  _FeaturedCard(project: filtered[i], isMobile: isMobile),
            );
          }),

          SizedBox(height: isMobile ? 32.h : 48.h),

          // ── Show More / Collapse button ────────────────────────────────────
          Obx(() {
            final showing = controller.showAllProjects.value;
            return _ShowMoreButton(
              expanded: showing,
              isMobile: isMobile,
              onTap: controller.toggleAllProjects,
            );
          }),

          // ── All GitHub repos (animated expansion) ─────────────────────────
          Obx(() {
            if (!controller.showAllProjects.value) return const SizedBox.shrink();

            return AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              child: Column(
                children: [
                  SizedBox(height: isMobile ? 32.h : 48.h),

                  // Section header for repos
                  _GithubReposHeader(isMobile: isMobile),
                  SizedBox(height: isMobile ? 24.h : 36.h),

                  // Loading state
                  if (controller.isLoadingRepos.value)
                    _LoadingRepos(isMobile: isMobile)

                  // Error state
                  else if (controller.reposError.value.isNotEmpty)
                    _ErrorState(
                      message: controller.reposError.value,
                      isMobile: isMobile,
                      onRetry: controller.fetchGithubRepos,
                    )

                  // Repos grid
                  else if (controller.githubRepos.isNotEmpty)
                    _GithubReposGrid(
                      repos: controller.githubRepos,
                      isMobile: isMobile,
                      isTablet: isTablet,
                      langColor: _langColor,
                      timeAgo: _timeAgo,
                    )

                  else
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Center(
                        child: Text(
                          'proj_no_repos_found'.tr,
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: isMobile ? Get.width * 0.034 : 14.sp,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── "Show More / Collapse" Button ────────────────────────────────────────────
class _ShowMoreButton extends StatefulWidget {
  final bool expanded;
  final bool isMobile;
  final VoidCallback onTap;
  const _ShowMoreButton({
    required this.expanded,
    required this.isMobile,
    required this.onTap,
  });

  @override
  State<_ShowMoreButton> createState() => _ShowMoreButtonState();
}

class _ShowMoreButtonState extends State<_ShowMoreButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    if (widget.expanded) _ctrl.forward();
  }

  @override
  void didUpdateWidget(_ShowMoreButton old) {
    super.didUpdateWidget(old);
    if (widget.expanded != old.expanded) {
      widget.expanded ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.isMobile;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 40.w : 24.w,
          vertical: isMobile ? 14.h : 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.35),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (b) =>
                  AppColors.primaryGradient.createShader(b),
              child: Text(
                widget.expanded
                    ? 'Show Less Projects'
                    : 'More Projects on GitHub',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? Get.width * 0.034 : 14.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            SizedBox(width: isMobile ? 14.w : 8.w),
            RotationTransition(
              turns: _rotation,
              child: ShaderMask(
                shaderCallback: (b) =>
                    AppColors.primaryGradient.createShader(b),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: isMobile ? Get.width * 0.05 : 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── GitHub Repos Section Header ──────────────────────────────────────────────
class _GithubReposHeader extends StatelessWidget {
  final bool isMobile;
  const _GithubReposHeader({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 50.r : 20.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 18.r : 10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF24292E).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.code_rounded,
              color: AppColors.textColor,
              size: isMobile ? Get.width * 0.055 : 22.sp,
            ),
          ),
          SizedBox(width: isMobile ? 24.w : 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'proj_all_repos'.tr,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.042 : 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'github.com/FlutterSanjay · ${'proj_all_repos_desc'.tr}',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: isMobile ? Get.width * 0.028 : 11.sp,
                  ),
                ),
              ],
            ),
          ),
          // GitHub icon
          Icon(
            Icons.open_in_new_rounded,
            color: AppColors.textMuted,
            size: isMobile ? Get.width * 0.04 : 16.sp,
          ),
        ],
      ),
    );
  }
}

// ─── Loading skeleton ─────────────────────────────────────────────────────────
class _LoadingRepos extends StatelessWidget {
  final bool isMobile;
  const _LoadingRepos({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final crossAxis = isMobile ? 1 : 1.sw < 1200 ? 2 : 3;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: isMobile ? 16.w : 20.w,
        mainAxisSpacing: isMobile ? 16.h : 20.h,
        childAspectRatio: isMobile ? 1.6 : 1.sw < 1200 ? 1.8 : 2.2,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => _SkeletonCard(isMobile: isMobile),
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  final bool isMobile;
  const _SkeletonCard({required this.isMobile});

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final opacity = 0.3 + (_anim.value * 0.3);
        return Container(
          padding: EdgeInsets.all(widget.isMobile ? 50.r : 18.r),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _skeletonBar(opacity, 0.5),
              SizedBox(height: 12.h),
              _skeletonBar(opacity, 1.0),
              SizedBox(height: 6.h),
              _skeletonBar(opacity, 0.7),
              const Spacer(),
              _skeletonBar(opacity, 0.3),
            ],
          ),
        );
      },
    );
  }

  Widget _skeletonBar(double opacity, double widthFactor) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
        height: widget.isMobile ? 10.h : 10.h,
        decoration: BoxDecoration(
          color: AppColors.borderBright.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String message;
  final bool isMobile;
  final VoidCallback onRetry;
  const _ErrorState(
      {required this.message,
      required this.isMobile,
      required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 50.r : 32.r),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline_rounded,
              color: const Color(0xFFEF4444),
              size: isMobile ? Get.width * 0.1 : 40.sp),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: isMobile ? Get.width * 0.033 : 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 40.w : 20.w,
                  vertical: isMobile ? 12.h : 10.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderBright, width: 1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(
                  'proj_retry'.tr,
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: isMobile ? Get.width * 0.033 : 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── GitHub Repos Grid ────────────────────────────────────────────────────────
class _GithubReposGrid extends StatelessWidget {
  final List<Map<String, dynamic>> repos;
  final bool isMobile;
  final bool isTablet;
  final Color Function(String?) langColor;
  final String Function(String?) timeAgo;

  const _GithubReposGrid({
    required this.repos,
    required this.isMobile,
    required this.isTablet,
    required this.langColor,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxis = isMobile ? 1 : isTablet ? 2 : 3;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: isMobile ? 16.w : 20.w,
        mainAxisSpacing: isMobile ? 16.h : 20.h,
        childAspectRatio: isMobile ? 1.5 : isTablet ? 1.7 : 2.1,
      ),
      itemCount: repos.length,
      itemBuilder: (ctx, i) => _GitHubRepoCard(
        repo: repos[i],
        isMobile: isMobile,
        langColor: langColor,
        timeAgo: timeAgo,
      ),
    );
  }
}

// ─── GitHub Repo Card ─────────────────────────────────────────────────────────
class _GitHubRepoCard extends StatefulWidget {
  final Map<String, dynamic> repo;
  final bool isMobile;
  final Color Function(String?) langColor;
  final String Function(String?) timeAgo;

  const _GitHubRepoCard({
    required this.repo,
    required this.isMobile,
    required this.langColor,
    required this.timeAgo,
  });

  @override
  State<_GitHubRepoCard> createState() => _GitHubRepoCardState();
}

class _GitHubRepoCardState extends State<_GitHubRepoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.repo;
    final bool isMobile = widget.isMobile;
    final String name = r['name'] as String? ?? '';
    final String? desc = r['description'] as String?;
    final String? lang = r['language'] as String?;
    final int stars = r['stargazers_count'] as int? ?? 0;
    final int forks = r['forks_count'] as int? ?? 0;
    final String url = r['html_url'] as String? ?? '';
    final String updated = widget.timeAgo(r['updated_at'] as String?);
    final Color lColor = widget.langColor(lang);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Get.find<HomeController>().openUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0.0, _hovered ? -4.0 : 0.0, 0.0),
          padding: EdgeInsets.all(isMobile ? 50.r : 16.r),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.primaryColor.withValues(alpha: 0.4)
                  : AppColors.borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? AppColors.primaryColor.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _hovered ? 18 : 6,
                offset: Offset(0, _hovered ? 8 : 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Repo name row ──────────────────────────────────────────────
              Row(
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: AppColors.textMuted,
                    size: isMobile ? Get.width * 0.035 : 13.sp,
                  ),
                  SizedBox(width: isMobile ? 10.w : 6.w),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: _hovered
                            ? AppColors.primaryLight
                            : AppColors.textColor,
                        fontSize: isMobile ? Get.width * 0.035 : 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.open_in_new_rounded,
                    color: _hovered
                        ? AppColors.primaryLight
                        : AppColors.textMuted,
                    size: isMobile ? Get.width * 0.03 : 11.sp,
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // ── Description ────────────────────────────────────────────────
              Expanded(
                child: Text(
                  desc?.isNotEmpty == true
                      ? desc!
                      : 'No description provided.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? Get.width * 0.028 : 11.sp,
                    height: 1.55,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 10.h),

              // ── Footer stats ───────────────────────────────────────────────
              Row(
                children: [
                  // Language
                  if (lang != null) ...[
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lColor,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8.w : 4.w),
                    Text(
                      lang,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? Get.width * 0.026 : 10.sp,
                      ),
                    ),
                    SizedBox(width: isMobile ? 14.w : 10.w),
                  ],
                  // Stars
                  Icon(
                    Icons.star_outline_rounded,
                    size: isMobile ? Get.width * 0.028 : 11.sp,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    '$stars',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: isMobile ? Get.width * 0.026 : 10.sp,
                    ),
                  ),
                  SizedBox(width: isMobile ? 10.w : 8.w),
                  // Forks
                  Icon(
                    Icons.call_split_rounded,
                    size: isMobile ? Get.width * 0.028 : 11.sp,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    '$forks',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: isMobile ? Get.width * 0.026 : 10.sp,
                    ),
                  ),
                  const Spacer(),
                  // Updated
                  if (updated.isNotEmpty)
                    Text(
                      updated,
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: isMobile ? Get.width * 0.024 : 9.sp,
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

// ─── Featured Card (same as before) ──────────────────────────────────────────
class _FeaturedCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isMobile;
  const _FeaturedCard({required this.project, required this.isMobile});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final Color accent = p['accent'] as Color;
    final bool isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0.0, _hovered ? -6.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.cardHoverColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _hovered
                ? accent.withValues(alpha: 0.45)
                : AppColors.borderColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withValues(alpha: 0.18)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _hovered ? 28 : 8,
              offset: Offset(0, _hovered ? 12 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image/icon header
            Container(
              height: isMobile ? 180.h : 160.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.2),
                    accent.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      p['icon'] as IconData,
                      size: isMobile ? 72 : 64,
                      color: accent.withValues(alpha: 0.35),
                    ),
                  ),
                  Positioned(
                    top: isMobile ? 14.h : 12.h,
                    left: isMobile ? 14.w : 14.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 18.w : 10.w,
                        vertical: isMobile ? 5.h : 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                          color: accent.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        p['category'] as String,
                        style: TextStyle(
                          color: accent,
                          fontSize: isMobile ? Get.width * 0.025 : 10.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 60.r : 20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'] as String,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: isMobile ? Get.width * 0.045 : 17.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: Text(
                        p['desc_key'].toString().tr,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: isMobile ? Get.width * 0.031 : 12.sp,
                          height: 1.65,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: (p['tech'] as List<String>).map((t) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 14.w : 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                                color: AppColors.borderColor, width: 1),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize:
                                  isMobile ? Get.width * 0.025 : 10.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 14.h),
                    GestureDetector(
                      onTap: () {
                        if (p['link'] != null) {
                          Get.find<HomeController>()
                              .openUrl(p['link'] as String);
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.open_in_new_rounded,
                            size: isMobile ? Get.width * 0.035 : 13.sp,
                            color: accent,
                          ),
                          SizedBox(width: isMobile ? 10.w : 5.w),
                          Text(
                            'View Project',
                            style: TextStyle(
                              color: accent,
                              fontSize:
                                  isMobile ? Get.width * 0.03 : 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
