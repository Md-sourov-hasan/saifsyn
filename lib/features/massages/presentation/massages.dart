import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/features/massages/controllers/chat_controller.dart';
import 'package:saifsyn/features/massages/data/model/chat_message_model.dart';

class MassagesScreen extends StatefulWidget {
  const MassagesScreen({super.key, this.receiverId});

  final int? receiverId;

  @override
  State<MassagesScreen> createState() => _MassagesScreenState();
}

class _MassagesScreenState extends State<MassagesScreen> {
  late final ChatController _chatController;
  late final String _controllerTag;

  @override
  void initState() {
    super.initState();
    final ownUserId = int.tryParse(StorageService.userId?.trim() ?? '') ?? 0;
    final fallbackReceiverId = ownUserId == 1 ? 2 : 1;
    final resolvedReceiverId = widget.receiverId ?? fallbackReceiverId;

    _controllerTag = 'chat-${DateTime.now().microsecondsSinceEpoch}';
    _chatController = Get.put(
      ChatController(
        initialReceiverId: resolvedReceiverId,
      ),
      tag: _controllerTag,
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<ChatController>(tag: _controllerTag)) {
      Get.delete<ChatController>(tag: _controllerTag, force: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Obx(() {
                if (_chatController.isLoading &&
                    _chatController.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_chatController.errorMessage.isNotEmpty &&
                    _chatController.messages.isEmpty) {
                  return _buildErrorState();
                }

                return RefreshIndicator(
                  onRefresh: _chatController.refreshMessages,
                  child: _chatController.messages.isEmpty
                      ? _buildEmptyState()
                      : ListView.separated(
                          controller: _chatController.scrollController,
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                          itemCount: _chatController.messages.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final item = _chatController.messages[index];
                            return _ChatBubble(
                              message: item.message,
                              time: _formatMessageTime(item),
                              isMe: _chatController.isMyMessage(item),
                            );
                          },
                        ),
                );
              }),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0B2A66), Color(0xFF2E6BFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: Get.back,
                  borderRadius: BorderRadius.circular(30.r),
                  child: Container(
                    width: 34.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'ST',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _chatController.headerTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _chatController.isLoading ? 'Connecting...' : 'Online',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.error_outline_rounded,
          size: 56.sp,
          color: const Color(0xFFE11D48),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            _chatController.errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF374151),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: ElevatedButton(
            onPressed: _chatController.loadMessages,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D4ED8),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: const Text('Retry'),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 130.h),
        Center(
          child: Container(
            width: 82.w,
            height: 82.h,
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 40.sp,
              color: const Color(0xFF1D4ED8),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Text(
          'No massages yet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Start by sending your first massage.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: 13.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: TextField(
                controller: _chatController.messageInputController,
                minLines: 1,
                maxLines: 4,
                onChanged: _chatController.onDraftChanged,
                onSubmitted: (_) => _chatController.sendMessage(),
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Write a massage...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Obx(() {
            final canSend = _chatController.canSend;
            return GestureDetector(
              onTap: canSend ? _chatController.sendMessage : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 46.w,
                height: 46.h,
                decoration: BoxDecoration(
                  gradient: canSend
                      ? const LinearGradient(
                          colors: [Color(0xFF1D4ED8), Color(0xFF2563EB)],
                        )
                      : null,
                  color: canSend ? null : const Color(0xFFD1D5DB),
                  shape: BoxShape.circle,
                  boxShadow: canSend
                      ? const [
                          BoxShadow(
                            color: Color(0x331D4ED8),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : const [],
                ),
                child: _chatController.isSending
                    ? SizedBox(
                        width: 18.w,
                        height: 18.h,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.sp,
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatMessageTime(ChatMessageModel item) {
    final timestamp = item.timestamp;
    if (timestamp == null) {
      return '';
    }
    return DateFormat('hh:mm a').format(timestamp.toLocal());
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    required this.time,
    required this.isMe,
  });

  final String message;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 285.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(
                  colors: [Color(0xFF1D4ED8), Color(0xFF1E40AF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isMe ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.r),
            topRight: Radius.circular(14.r),
            bottomLeft: Radius.circular(isMe ? 14.r : 4.r),
            bottomRight: Radius.circular(isMe ? 4.r : 14.r),
          ),
          border: isMe ? null : Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : const Color(0xFF111827),
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.45,
              ),
            ),
            if (time.isNotEmpty) ...[
              SizedBox(height: 4.h),
              Text(
                time,
                style: TextStyle(
                  color: isMe
                      ? Colors.white.withValues(alpha: 0.85)
                      : const Color(0xFF6B7280),
                  fontSize: 11.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
