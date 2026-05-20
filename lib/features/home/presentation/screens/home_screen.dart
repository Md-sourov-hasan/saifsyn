import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';
import '../widgets/home_header.dart';
import '../widgets/upgrade_card.dart';
import '../widgets/search_bar.dart' as custom;
import '../widgets/my_recommendations_card.dart';
import '../widgets/tracked_stocks_card.dart';
import '../widgets/market_highlights_section.dart';
import '../widgets/related_news_card.dart';
import '../widgets/stock_item.dart';

class StockSearchData {
  final String symbol;
  final String name;
  final String price;
  final String change;
  final bool isPositive;
  final String? halalStatus;
  final String? riskLevel;

  StockSearchData({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    this.isPositive = true,
    this.halalStatus,
    this.riskLevel,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  List<StockSearchData> _getAllStocks(LocalizationService localizationService) {
    return [
      StockSearchData(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: '\$173.50',
        change: '+1.25%',
        isPositive: true,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
      StockSearchData(
        symbol: 'NVDA',
        name: 'NVIDIA Corp',
        price: '\$850.00',
        change: '+15.20%',
        isPositive: true,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
      StockSearchData(
        symbol: 'MSFT',
        name: 'Microsoft',
        price: '\$410.00',
        change: '+0.50%',
        isPositive: true,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
      StockSearchData(
        symbol: 'AMZN',
        name: 'Amazon.com',
        price: '\$175.00',
        change: '+3.00%',
        isPositive: true,
        halalStatus: localizationService.translate('doubtful'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
      StockSearchData(
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        price: '\$145.00',
        change: '+2.30%',
        isPositive: true,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
      StockSearchData(
        symbol: 'TSLA',
        name: 'Tesla Inc.',
        price: '\$248.00',
        change: '-3.50%',
        isPositive: false,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('highRisk'),
      ),
      StockSearchData(
        symbol: 'META',
        name: 'Meta Platforms',
        price: '\$380.00',
        change: '+8.00%',
        isPositive: true,
        halalStatus: localizationService.translate('halal'),
        riskLevel: localizationService.translate('lowRisk'),
      ),
    ];
  }

  List<StockSearchData> get _filteredStocks {
    final localizationService = Get.find<LocalizationService>();
    final allStocks = _getAllStocks(localizationService);
    if (_searchQuery.isEmpty) {
      return [];
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
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF00008B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                child: Column(
                  children: [
                    const HomeHeader(),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: const UpgradeCard(),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),

            // Content Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 17.h),

                  // Search Bar
                  custom.SearchBar(
                    onSearchChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                  ),

                  SizedBox(height: 17.h),

                  // Search Results (only show when searching)
                  if (_searchQuery.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.w),
                          child: Text(
                            _filteredStocks.isEmpty
                                ? localizationService.translate('noResultsFound')
                                : '${localizationService.translate('searchResults')} (${_filteredStocks.length})',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0E162B),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        if (_filteredStocks.isNotEmpty) ...buildSearchResults(),
                        if (_filteredStocks.isEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48.sp,
                                    color: const Color(0xFF99A1AF),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    localizationService.translate('noStocksFound'),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF99A1AF),
                                      fontFamily: 'Arimo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 27.h),
                      ],
                    ),

                  // Regular content (hide when searching)
                  if (_searchQuery.isEmpty) ...[
                    // My Recommendations Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: const MyRecommendationsCard(),
                    ),

                    SizedBox(height: 19.h),

                    // Tracked Stocks Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: const TrackedStocksCard(),
                    ),

                    SizedBox(height: 27.h),

                    // Market Highlights Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: const MarketHighlightsSection(),
                    ),

                    SizedBox(height: 27.h),

                    // Related News Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: const RelatedNewsCard(),
                    ),

                    SizedBox(height: 50.h),
                  ],
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildSearchResults() {
    return _filteredStocks.asMap().entries.map((entry) {
      final index = entry.key;
      final stock = entry.value;
      return Column(
        children: [
          if (index > 0) SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: StockItem(
              symbol: stock.symbol,
              name: stock.name,
              price: stock.price,
              change: stock.change,
              isPositive: stock.isPositive,
              halalStatus: stock.halalStatus,
              riskLevel: stock.riskLevel,
            ),
          ),
        ],
      );
    }).toList();
  }
}
