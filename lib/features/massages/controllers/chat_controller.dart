import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/features/massages/data/model/chat_message_model.dart';
import 'package:saifsyn/features/massages/data/service/chat_services.dart';

class ChatController extends GetxController {
  ChatController({
    required this.initialReceiverId,
  });

  final int initialReceiverId;

  final ChatServices _chatServices = ChatServices();

  final TextEditingController messageInputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatMessageModel> _messages = <ChatMessageModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _isSending = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _draftMessage = ''.obs;
  final RxInt _resolvedReceiverId = 0.obs;
  final RxInt _currentUserId = 0.obs;

  List<ChatMessageModel> get messages => _messages;
  bool get isLoading => _isLoading.value;
  bool get isSending => _isSending.value;
  String get errorMessage => _errorMessage.value;
  String get draftMessage => _draftMessage.value;
  int get currentUserId => _currentUserId.value;
  bool get canSend => draftMessage.trim().isNotEmpty && !isSending;

  @override
  void onInit() {
    super.onInit();
    _resolvedReceiverId.value = initialReceiverId;
    loadMessages();
  }

  Future<void> loadMessages({
    bool showLoader = true,
    bool showErrorSnackbar = true,
  }) async {
    await _hydrateCurrentUserId();
    if (currentUserId <= 0) {
      _errorMessage.value = 'Invalid user id. Please login again.';
      if (showErrorSnackbar) {
        Get.snackbar('Error', _errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    final receiverId = _resolvedReceiverId.value;
    if (receiverId <= 0) {
      _errorMessage.value = 'Invalid receiver id.';
      if (showErrorSnackbar) {
        Get.snackbar('Error', _errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
      return;
    }

    if (showLoader) {
      _isLoading.value = true;
    }
    _errorMessage.value = '';

    try {
      final items = await _chatServices.getFullConversation(
        senderId: currentUserId,
        receiverId: receiverId,
      );
      items.sort(_compareMessages);
      _messages.assignAll(items);
      _resolveReceiverIdFromMessages();
      _jumpToBottom();
    } catch (e) {
      _errorMessage.value = _cleanError(e);
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

  Future<void> refreshMessages() async {
    await loadMessages(showLoader: false, showErrorSnackbar: false);
  }

  Future<void> sendMessage() async {
    final text = messageInputController.text.trim();
    if (text.isEmpty || isSending) {
      return;
    }

    await _hydrateCurrentUserId();
    if (currentUserId <= 0) {
      Get.snackbar(
        'Error',
        'Invalid user id. Please login again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final receiverId = _resolvedReceiverId.value;
    if (receiverId <= 0) {
      Get.snackbar(
        'Error',
        'Receiver id could not be resolved.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _isSending.value = true;
    try {
      final sentMessage = await _chatServices.sendMessage(
        receiverId: receiverId,
        message: text,
      );
      messageInputController.clear();
      _draftMessage.value = '';

      _messages.add(sentMessage);
      _messages.sort(_compareMessages);
      _resolveReceiverIdFromMessages();
      _jumpToBottom();
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanError(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isSending.value = false;
    }
  }

  void onDraftChanged(String value) {
    _draftMessage.value = value;
  }

  bool isMyMessage(ChatMessageModel item) => item.isFromUser(currentUserId);

  String get headerTitle {
    for (final item in _messages.reversed) {
      if (item.senderId != currentUserId &&
          (item.sender?.name.trim().isNotEmpty ?? false)) {
        return item.sender!.name.trim();
      }
      if (item.receiverId != currentUserId &&
          (item.receiver?.name.trim().isNotEmpty ?? false)) {
        return item.receiver!.name.trim();
      }
    }
    return 'Support Team';
  }

  void _resolveReceiverIdFromMessages() {
    for (final item in _messages.reversed) {
      if (item.senderId != currentUserId && item.senderId > 0) {
        _resolvedReceiverId.value = item.senderId;
        return;
      }
      if (item.receiverId != currentUserId && item.receiverId > 0) {
        _resolvedReceiverId.value = item.receiverId;
        return;
      }
    }
  }

  Future<void> _hydrateCurrentUserId() async {
    final raw = await StorageService.getUserIdValue();
    _currentUserId.value = int.tryParse(raw?.trim() ?? '') ?? 0;
  }

  int _compareMessages(ChatMessageModel a, ChatMessageModel b) {
    final aTime = a.timestamp;
    final bTime = b.timestamp;

    if (aTime != null && bTime != null) {
      return aTime.compareTo(bTime);
    }
    if (aTime != null && bTime == null) {
      return 1;
    }
    if (aTime == null && bTime != null) {
      return -1;
    }
    return a.id.compareTo(b.id);
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) {
        return;
      }
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String _cleanError(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }

  @override
  void onClose() {
    messageInputController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
