import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_colors.dart';
import '../controllers/chatbot_controller.dart';

class ChatbotWidget extends StatelessWidget {
  const ChatbotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Put the controller in Get if not already
    final ChatbotController controller = Get.put(ChatbotController());
    final bool isMobile = 1.sw < 800;

    return Align(
      alignment: Alignment.bottomRight,
      child: Obx(() {
        if (!controller.isOpen.value) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: isMobile ? 24.h : 40.h,
              right: isMobile ? 24.w : 40.w,
            ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: controller.toggleChat,
              child: Container(
                width: isMobile ? 60.w : 64.w,
                height: isMobile ? 60.w : 64.w,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        );
      }

      // Chat window is open
      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;
      final double pb = isMobile ? 20.h : 40.h;
      final double pr = isMobile ? 20.w : 40.w;

      double chatHeight = isMobile ? (screenHeight * 0.7) : 600.h;
      if (chatHeight > screenHeight - pb - 20) {
        chatHeight = screenHeight - pb - 20;
      }
      
      double chatWidth = isMobile ? (screenWidth - 40.w) : 400.w;

      return Padding(
        padding: EdgeInsets.only(bottom: pb, right: pr),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: chatWidth,
            height: chatHeight,
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(19.r)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 18.r,
                          backgroundImage: NetworkImage(
                            controller.botUser.profileImage ?? '',
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sanjay's AI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: controller.toggleChat,
                        icon: const Icon(Icons.close_rounded,
                            color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                // Chat Area
                Expanded(
                  child: DashChat(
                    currentUser: controller.currentUser,
                    messages: controller.chatMessages,
                    onSend: controller.onSend,
                    typingUsers: controller.isTyping.value
                        ? [controller.botUser]
                        : [],
                    messageOptions: MessageOptions(
                      maxWidth: chatWidth * 0.75,
                      currentUserContainerColor: AppColors.primaryColor,
                      currentUserTextColor: Colors.white,
                      containerColor: AppColors.surfaceColor,
                      textColor: AppColors.textColor,
                      showCurrentUserAvatar: false,
                      showOtherUsersAvatar: true,
                      avatarBuilder: (user, onPress, onLongPress) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundImage:
                                NetworkImage(user.profileImage ?? ''),
                          ),
                        );
                      },
                    ),
                    inputOptions: InputOptions(
                      inputDecoration: InputDecoration(
                        hintText: "Ask something...",
                        hintStyle: TextStyle(color: AppColors.textMuted),
                        filled: true,
                        fillColor: AppColors.backgroundColor,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(
                              color: AppColors.borderColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(
                              color: AppColors.borderColor, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(
                              color: AppColors.primaryColor, width: 1),
                        ),
                      ),
                      inputTextStyle: TextStyle(color: AppColors.textColor),
                      sendButtonBuilder: (void Function() onSend) {
                        return IconButton(
                          onPressed: onSend,
                          icon: Icon(Icons.send_rounded,
                              color: AppColors.primaryColor),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      }),
    );
  }
}
