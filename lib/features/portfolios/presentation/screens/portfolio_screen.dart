import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/portfolio_stock_card.dart';

class StockData {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final String changePercent;
  final String supportPrice;
  final String resistancePrice;
  final String recommendation;
  final bool isPositive;
  final bool isPrimary;

  StockData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.supportPrice,
    required this.resistancePrice,
    required this.recommendation,
    this.isPositive = true,
    this.isPrimary = false,
  });
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String _searchQuery = '';

  List<StockData> _getAllStocks(LocalizationService localizationService) {
    return [
      StockData(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: '\$173.50',
        change: '+1.25',
        changePercent: '0.72%',
        supportPrice: '170',
        resistancePrice: '175',
        // store recommendation as a key (not translated) so UI can localize and
        // decide colors/labels consistently inside the card
        recommendation: 'buy',
        isPositive: true,
        isPrimary: true,
      ),
      StockData(
        symbol: 'NVDA',
        name: 'NVIDIA Corp',
        price: '\$850.00',
        change: '+15.20',
        changePercent: '1.82%',
        supportPrice: '840',
        resistancePrice: '860',
        recommendation: 'buy',
        isPositive: true,
      ),
      StockData(
        symbol: 'MSFT',
        name: 'Microsoft',
        price: '\$410.00',
        change: '+0.50',
        changePercent: '0.12%',
        supportPrice: '405',
        resistancePrice: '415',
        recommendation: 'hold',
        isPositive: true,
      ),
      StockData(
        symbol: 'AMZN',
        name: 'Amazon.com',
        price: '\$175.00',
        change: '+3.00',
        changePercent: '1.74%',
        supportPrice: '170',
        resistancePrice: '180',
        recommendation: 'buy',
        isPositive: true,
      ),
      StockData(
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        price: '\$145.00',
        change: '+2.30',
        changePercent: '1.61%',
        supportPrice: '142',
        resistancePrice: '148',
        recommendation: 'buy',
        isPositive: true,
      ),
      StockData(
        symbol: 'TSLA',
        name: 'Tesla Inc.',
        price: '\$248.00',
        change: '-3.50',
        changePercent: '-1.39%',
        supportPrice: '240',
        resistancePrice: '255',
        recommendation: 'hold',
        isPositive: false,
      ),
      StockData(
        symbol: 'META',
        name: 'Meta Platforms',
        price: '\$380.00',
        change: '+8.00',
        changePercent: '2.15%',
        supportPrice: '375',
        resistancePrice: '390',
        recommendation: 'buy',
        isPositive: true,
      ),
    ];
  }

  List<StockData> get _filteredStocks {
    final localizationService = Get.find<LocalizationService>();
    final allStocks = _getAllStocks(localizationService);
    if (_searchQuery.isEmpty) {
      return allStocks;
    }
    return allStocks.where((stock) {
      final query = _searchQuery.toLowerCase();
      return stock.symbol.toLowerCase().contains(query) ||
          stock.name.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Fixed Header
          PortfolioHeader(
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),

          // Scrollable Stock List
          Expanded(
            child: _filteredStocks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64.sp,
                          color: const Color(0xFF99A1AF),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          localizationService.translate('noStocksFound'),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF99A1AF),
                            fontFamily: 'Arimo',
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: Column(
                      children: _filteredStocks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final stock = entry.value;
                        return Column(
                          children: [
                            if (index > 0) SizedBox(height: 12.h),
                            PortfolioStockCard(
                              symbol: stock.symbol,
                              name: stock.name,
                              price: stock.price,
                              change: stock.change,
                              changePercent: stock.changePercent,
                              supportPrice: stock.supportPrice,
                              resistancePrice: stock.resistancePrice,
                              recommendation: stock.recommendation,
                              isPositive: stock.isPositive,
                              isPrimary: stock.isPrimary,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
