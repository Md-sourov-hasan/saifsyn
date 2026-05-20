import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/ai_analysis/data/model/ai_analysis_response_model.dart';

class AnalysisDetailsController extends GetxController {
  final Rxn<AnalysisItemModel> _analysis = Rxn<AnalysisItemModel>();

  AnalysisItemModel? get analysis => _analysis.value;
  String get symbol => _normalizeSymbol(analysis?.symbol ?? '');
  String get name => analysis?.name ?? '';
  String get status => analysis?.status ?? '';
  String get recommendation => analysis?.recommendation ?? '';
  String get note => analysis?.note ?? '';
  String get createdAt => _formatDateTime(analysis?.createdAt);
  String get updatedAt => _formatDateTime(analysis?.updatedAt);

  @override
  void onInit() {
    super.onInit();
    _analysis.value = _parseArgument(Get.arguments) ?? _fallbackItem();
  }

  AnalysisItemModel? _parseArgument(dynamic args) {
    if (args is AnalysisItemModel) {
      return args;
    }

    if (args is Map<String, dynamic>) {
      final rawData = args['data'];
      if (rawData is Map<String, dynamic>) {
        return AnalysisItemModel.fromJson(rawData);
      }

      if (args.containsKey('symbol') && args.containsKey('name')) {
        return AnalysisItemModel.fromJson(args);
      }
    }

    return null;
  }

  String _normalizeSymbol(String value) {
    return value.trim().replaceAll(RegExp(r'[\.\s]+$'), '');
  }

  String _formatDateTime(String? rawValue) {
    final value = rawValue?.trim() ?? '';
    if (value.isEmpty) {
      return 'N/A';
    }

    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }

    return DateFormat('dd MMM yyyy, hh:mm a').format(parsed.toLocal());
  }

  AnalysisItemModel _fallbackItem() {
    return AnalysisItemModel(
      id: 1,
      symbol: 'AAPL.',
      name: 'Apple Inc.',
      status: 'COMPLIANT',
      recommendation:
          'This stock is suitable for Shariah-compliant portfolios.',
      note: 'Check latest quarterly report for details before investing.',
      createdAt: '2026-02-18T06:51:47.000000Z',
      updatedAt: '2026-02-19T04:23:23.000000Z',
    );
  }
}
