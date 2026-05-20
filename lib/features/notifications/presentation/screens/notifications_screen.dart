import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/notifications/controllers/notification_controller.dart';
import 'package:saifsyn/features/notifications/data/model/bell_notification_model.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_tabs.dart';
import '../widgets/notifications_header.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final NotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchNotifications(showLoader: _controller.totalCount == 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final notifications = _controller.filteredNotifications;

          return Column(
            children: [
              NotificationsHeader(unreadCount: _controller.unreadCount),
              NotificationFilterTabs(
                totalCount: _controller.totalCount,
                unreadCount: _controller.unreadCount,
                showUnreadOnly: _controller.showUnreadOnly,
                onFilterChanged: _controller.setShowUnreadOnly,
                onClearAll: _clearAllNotifications,
              ),
              Expanded(
                child: _controller.isLoading && _controller.totalCount == 0
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: _controller.refreshNotifications,
                        child: notifications.isEmpty
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(height: 120.h),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.notifications_off_outlined,
                                          size: 64.sp,
                                          color: const Color(0xFF99A1AE),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'No notifications',
                                          style: TextStyle(
                                            color: const Color(0xFF99A1AE),
                                            fontSize: 16.sp,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.all(24.w),
                                itemCount: notifications.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final notification = notifications[index];
                                  return NotificationCard(
                                    icon: Icons.notifications_active_outlined,
                                    iconBackgroundColor:
                                        const Color(0xFFDBEAFE),
                                    title: _title(notification),
                                    message: _message(notification),
                                    timeAgo:
                                        _formatTimeAgo(notification.createdAt),
                                    isUnread: notification.isUnread,
                                    onTap: _controller.isMarkingAsRead(
                                      notification.id,
                                    )
                                        ? null
                                        : () {
                                            _controller.markAsRead(
                                              notification,
                                            );
                                          },
                                  );
                                },
                              ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String _title(BellNotificationItemModel notification) {
    final symbol = notification.analysis?.symbol.trim() ?? '';
    final name = notification.analysis?.name.trim() ?? '';

    if (symbol.isNotEmpty) {
      return 'Stock Alert: $symbol';
    }
    if (name.isNotEmpty) {
      return name;
    }
    return 'Stock Notification';
  }

  String _message(BellNotificationItemModel notification) {
    final note = notification.analysis?.note.trim() ?? '';
    if (note.isNotEmpty) {
      return note;
    }

    final name = notification.analysis?.name.trim() ?? '';
    if (name.isNotEmpty) {
      return name;
    }
    return 'You have a new notification.';
  }

  String _formatTimeAgo(DateTime? value) {
    if (value == null) {
      return '--';
    }

    final now = DateTime.now().toUtc();
    final difference = now.difference(value.toUtc());

    if (difference.inSeconds < 60) {
      return 'Just now';
    }
    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes == 1 ? '' : 's'} ago';
    }
    if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours == 1 ? '' : 's'} ago';
    }
    if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'} ago';
    }

    return DateFormat('dd MMM yyyy').format(value.toLocal());
  }

  void _clearAllNotifications() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear All Notifications'),
        content:
            const Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _controller.clearAllNotifications();
              Get.back();
              Get.snackbar(
                'Success',
                'All notifications cleared',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
