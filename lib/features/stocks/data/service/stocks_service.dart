import 'dart:convert';

import 'package:saifsyn/core/services/network_caller.dart';
import 'package:saifsyn/core/services/storage_service.dart';
import 'package:saifsyn/core/utils/constants/api_constants.dart';
import 'package:saifsyn/core/utils/logging/logger.dart';
import 'package:saifsyn/features/stocks/data/model/wishlist_item_model.dart';
import 'package:saifsyn/features/stocks/data/model/zoya_stocks_models.dart';

class StocksService {
  final NetworkCaller _networkCaller = NetworkCaller();

  Future<ZoyaStockReport?> getSpecificStock(String symbol) async {
    final normalizedSymbol = symbol.trim().toUpperCase();
    if (normalizedSymbol.isEmpty) {
      throw Exception('Stock symbol is required.');
    }

    final responseData = await _sendGetRequest(
      ApiConstants.zoyaStock,
      queryParams: {'symbol': normalizedSymbol},
    );

    return ZoyaStockResponse.fromJson(responseData).report;
  }

  Future<WishlistItem> addToWishlist(String stockSymbol) async {
    final normalizedSymbol = stockSymbol.trim().toUpperCase();
    if (normalizedSymbol.isEmpty) {
      throw Exception('Stock symbol is required.');
    }

    final token = _requireAuthToken();
    final response = await _networkCaller.postRequest(
      ApiConstants.wishlist,
      token: token,
      headers: const {'Accept': 'application/json'},
      body: {'stock_symbol': normalizedSymbol},
    );

    AppLoggerHelper.debug(
      'WISHLIST POST RESPONSE <= ${response.statusCode} ${ApiConstants.wishlist}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final responseMap = response.responseData as Map<String, dynamic>;
      if (!_isApiSuccess(responseMap)) {
        throw Exception(
          responseMap['message']?.toString() ??
              'Failed to add stock to wishlist.',
        );
      }
      final data = responseMap['data'];
      if (data is Map<String, dynamic>) {
        return WishlistItem.fromJson(data);
      }
      throw Exception('Invalid wishlist response data.');
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to add stock to wishlist.',
    );
  }

  Future<List<WishlistItem>> getWishlist() async {
    final responseData = await _sendGetRequest(ApiConstants.wishlist);
    final data = responseData['data'];
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(WishlistItem.fromJson)
          .toList();
    }
    return <WishlistItem>[];
  }

  Future<void> deleteWishlistItem(int wishlistId) async {
    final token = _requireAuthToken();
    final response = await _networkCaller.deleteRequest(
      ApiConstants.wishlistById(wishlistId),
      token: token,
      headers: const {'Accept': 'application/json'},
    );

    AppLoggerHelper.debug(
      'WISHLIST DELETE RESPONSE <= ${response.statusCode} ${ApiConstants.wishlistById(wishlistId)}',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess) {
      if (response.responseData is Map<String, dynamic> &&
          !_isApiSuccess(response.responseData)) {
        final responseMap = response.responseData as Map<String, dynamic>;
        throw Exception(
          responseMap['message']?.toString() ??
              'Failed to remove stock from wishlist.',
        );
      }
      return;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to remove stock from wishlist.',
    );
  }

  Future<ZoyaRatingsResponse> getRatingsForUsMarket({
    String? nextToken,
  }) async {
    final queryParams = <String, dynamic>{};
    if (nextToken != null && nextToken.trim().isNotEmpty) {
      queryParams['nextToken'] = nextToken.trim();
    }

    final responseData = await _sendGetRequest(
      ApiConstants.zoyaReports,
      queryParams: queryParams.isEmpty ? null : queryParams,
    );

    return ZoyaRatingsResponse.fromJson(responseData);
  }

  Future<ZoyaCompliantStocksResponse> getCompliantStocks({
    String status = 'COMPLIANT',
    String? nextToken,
  }) async {
    final queryParams = <String, dynamic>{
      'status': status,
    };
    if (nextToken != null && nextToken.trim().isNotEmpty) {
      queryParams['nextToken'] = nextToken.trim();
    }

    final responseData = await _sendGetRequest(
      ApiConstants.zoyaCompliantStocks,
      queryParams: queryParams,
    );

    return ZoyaCompliantStocksResponse.fromJson(responseData);
  }

  Future<ZoyaEtfReportsResponse> getEtfReports({
    String? nextToken,
  }) async {
    final queryParams = <String, dynamic>{};
    if (nextToken != null && nextToken.trim().isNotEmpty) {
      queryParams['nextToken'] = nextToken.trim();
    }

    final responseData = await _sendGetRequest(
      ApiConstants.zoyaEtfReports,
      queryParams: queryParams.isEmpty ? null : queryParams,
    );

    return ZoyaEtfReportsResponse.fromJson(responseData);
  }

  Future<Map<String, dynamic>> _sendGetRequest(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    final authToken = _requireAuthToken();
    if (queryParams != null && queryParams.isNotEmpty) {
      AppLoggerHelper.debug('QUERY PARAMS => ${_toPrettyJson(queryParams)}');
    }

    final response = await _networkCaller.getRequest(
      url,
      token: authToken,
      headers: const {
        'Accept': 'application/json',
      },
      queryParams: queryParams,
    );

    AppLoggerHelper.debug(
      'STOCKS RESPONSE <= ${response.statusCode} $url',
    );
    AppLoggerHelper.debug(
      'RESPONSE BODY => ${_toPrettyJson(response.responseData)}',
    );

    if (response.isSuccess && response.responseData is Map<String, dynamic>) {
      final responseMap = response.responseData as Map<String, dynamic>;
      if (!_isApiSuccess(responseMap)) {
        throw Exception(
          responseMap['message']?.toString() ?? 'Failed to fetch stock data.',
        );
      }
      return responseMap;
    }

    throw Exception(
      response.errorMessage.isNotEmpty
          ? response.errorMessage
          : 'Failed to fetch stock data.',
    );
  }

  String _requireAuthToken() {
    final token = StorageService.token?.trim() ?? '';
    if (token.isEmpty) {
      throw Exception('Login required. Token not found.');
    }
    return token.toLowerCase().startsWith('bearer ') ? token : 'Bearer $token';
  }

  String _toPrettyJson(dynamic value) {
    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }

  bool _isApiSuccess(Map<String, dynamic> responseMap) {
    if (!responseMap.containsKey('success')) {
      return true;
    }
    final success = responseMap['success'];
    if (success is bool) {
      return success;
    }
    return success?.toString().toLowerCase() == 'true';
  }
}
