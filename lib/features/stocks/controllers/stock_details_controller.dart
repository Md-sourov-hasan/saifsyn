import 'package:get/get.dart';
import 'package:saifsyn/features/stocks/data/model/wishlist_item_model.dart';
import 'package:saifsyn/features/stocks/data/service/stocks_service.dart';

class StockDetailsController extends GetxController {
  final StocksService _stocksService = StocksService();

  final isLoading = false.obs;
  final isWishlistLoading = false.obs;
  final stockData = <String, dynamic>{}.obs;
  final RxList<WishlistItem> _wishlistItems = <WishlistItem>[].obs;
  final RxList<String> _pendingSymbols = <String>[].obs;
  final RxList<int> _pendingDeleteIds = <int>[].obs;

  List<WishlistItem> get wishlistItems => _wishlistItems;
  bool get hasWishlistItems => _wishlistItems.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    stockData.value = _parseStockData(Get.arguments) ??
        {
          'symbol': 'AAPL',
          'name': 'Apple Inc.',
          'price': '\$178.25',
          'change': '+2.4%',
          'isPositive': true,
          'isHalalCertified': true,
          'riskLevel': 'LOW RISK',
        };
    loadWishlist();
  }

  Future<void> refreshStockData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
  }

  Future<void> loadWishlist({bool showLoading = true}) async {
    if (showLoading) {
      isWishlistLoading.value = true;
    }
    try {
      final items = await _stocksService.getWishlist();
      _wishlistItems.assignAll(items);
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (showLoading) {
        isWishlistLoading.value = false;
      }
    }
  }

  bool isSymbolInWishlist(String symbol) {
    final normalized = _normalizeSymbol(symbol);
    if (normalized.isEmpty) return false;
    for (final item in _wishlistItems) {
      if (item.normalizedSymbol == normalized) {
        return true;
      }
    }
    return false;
  }

  bool isSymbolActionInProgress(String symbol) {
    final normalized = _normalizeSymbol(symbol);
    return _pendingSymbols.contains(normalized);
  }

  bool isDeleteInProgress(int wishlistId) {
    return _pendingDeleteIds.contains(wishlistId);
  }

  Future<void> addSymbolToWishlist(
    String symbol, {
    bool showSuccessMessage = true,
  }) async {
    final normalized = _normalizeSymbol(symbol);
    if (normalized.isEmpty) {
      Get.snackbar(
        'Validation',
        'Stock symbol is required.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isSymbolInWishlist(normalized)) {
      if (showSuccessMessage) {
        Get.snackbar(
          'Info',
          '$normalized is already in watchlist.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }

    if (_pendingSymbols.contains(normalized)) {
      return;
    }

    _pendingSymbols.add(normalized);
    try {
      final createdItem = await _stocksService.addToWishlist(normalized);
      _wishlistItems.insert(0, createdItem);

      if (showSuccessMessage) {
        Get.snackbar(
          'Success',
          '$normalized added to watchlist.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        _cleanErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _pendingSymbols.remove(normalized);
    }
  }

  Future<void> removeWishlistItem(
    int wishlistId, {
    String? symbol,
    bool showSuccessMessage = true,
  }) async {
    if (_pendingDeleteIds.contains(wishlistId)) {
      return;
    }

    final existingIndex =
        _wishlistItems.indexWhere((item) => item.id == wishlistId);
    WishlistItem? removedItem;
    if (existingIndex != -1) {
      removedItem = _wishlistItems[existingIndex];
      _wishlistItems.removeAt(existingIndex);
    }

    _pendingDeleteIds.add(wishlistId);
    try {
      await _stocksService.deleteWishlistItem(wishlistId);
      if (showSuccessMessage) {
        final removedSymbol = symbol ?? removedItem?.stockSymbol ?? 'Stock';
        Get.snackbar(
          'Removed',
          '$removedSymbol removed from watchlist.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (removedItem != null && existingIndex != -1) {
        _wishlistItems.insert(existingIndex, removedItem);
      }
      Get.snackbar(
        'Error',
        _cleanErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _pendingDeleteIds.remove(wishlistId);
    }
  }

  Future<void> toggleWishlistForSymbol(String symbol) async {
    final normalized = _normalizeSymbol(symbol);
    if (normalized.isEmpty) {
      return;
    }

    if (_pendingSymbols.contains(normalized)) {
      return;
    }

    WishlistItem? matchedItem;
    for (final item in _wishlistItems) {
      if (item.normalizedSymbol == normalized) {
        matchedItem = item;
        break;
      }
    }
    if (matchedItem != null) {
      await removeWishlistItem(
        matchedItem.id,
        symbol: matchedItem.stockSymbol,
      );
      return;
    }

    await addSymbolToWishlist(normalized);
  }

  Future<void> toggleFavorite() async {
    final symbol = stockData['symbol']?.toString() ?? '';
    await toggleWishlistForSymbol(symbol);
  }

  void navigateToTrade() {
    // TODO: Implement navigation to trade screen
  }

  Map<String, dynamic>? _parseStockData(dynamic args) {
    if (args is Map<String, dynamic>) {
      return args;
    }
    if (args is Map) {
      return args.map(
        (key, value) => MapEntry(key.toString(), value),
      );
    }
    return null;
  }

  String _normalizeSymbol(String value) {
    return value.trim().replaceAll(RegExp(r'[\.\s]+$'), '').toUpperCase();
  }

  String _cleanErrorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '').trim();
  }
}
