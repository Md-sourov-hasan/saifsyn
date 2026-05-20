import 'package:get/get.dart';
import 'package:saifsyn/core/services/firebase/notification_service.dart';
import 'package:saifsyn/features/notifications/data/model/bell_notification_model.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();

  final RxList<BellNotificationItemModel> _notifications =
      <BellNotificationItemModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _showUnreadOnly = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxSet<int> _markingReadIds = <int>{}.obs;

  List<BellNotificationItemModel> get notifications => _notifications;
  bool get isLoading => _isLoading.value;
  bool get showUnreadOnly => _showUnreadOnly.value;
  String get errorMessage => _errorMessage.value;
  int get unreadCount => _notifications.where((item) => item.isUnread).length;
  int get totalCount => _notifications.length;
  List<BellNotificationItemModel> get filteredNotifications {
    if (!showUnreadOnly) {
      return _notifications;
    }
    return _notifications.where((item) => item.isUnread).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications({
    bool showLoader = true,
    bool showErrorSnackbar = true,
  }) async {
    if (showLoader) {
      _isLoading.value = true;
    }
    _errorMessage.value = '';

    try {
      final response = await _notificationService.getBellNotifications();
      _notifications.assignAll(response.data);
    } catch (e) {
      _errorMessage.value = _cleanErrorMessage(e);
      if (showErrorSnackbar) {
        Get.snackbar(
          'Error',
          _errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (showLoader) {
        _isLoading.value = false;
      }
    }
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications(showLoader: false);
  }

  void clearAllNotifications() {
    _notifications.clear();
  }

  void setShowUnreadOnly(bool value) {
    _showUnreadOnly.value = value;
  }

  bool isMarkingAsRead(int notificationId) {
    return _markingReadIds.contains(notificationId);
  }

  Future<void> markAsRead(BellNotificationItemModel notification) async {
    if (!notification.isUnread || isMarkingAsRead(notification.id)) {
      return;
    }

    _markingReadIds.add(notification.id);
    try {
      await _notificationService.markNotificationAsRead(notification.id);

      final index = _notifications.indexWhere(
        (item) => item.id == notification.id,
      );
      if (index != -1) {
        _notifications[index] = _notifications[index].copyWith(isRead: 1);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _markingReadIds.remove(notification.id);
    }
  }

  String _cleanErrorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
