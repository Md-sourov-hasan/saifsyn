import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saifsyn/features/stocks/controllers/stock_details_controller.dart';
import 'package:saifsyn/features/stocks/data/model/wishlist_item_model.dart';

class WhatchlistDashboard extends StatefulWidget {
  const WhatchlistDashboard({super.key});

  @override
  State<WhatchlistDashboard> createState() => _WhatchlistDashboardState();
}

class _WhatchlistDashboardState extends State<WhatchlistDashboard> {
  late final StockDetailsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.isRegistered<StockDetailsController>()
        ? Get.find<StockDetailsController>()
        : Get.put(StockDetailsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.isWishlistLoading.value &&
          _controller.wishlistItems.isEmpty) {
        _controller.loadWishlist();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      body: SafeArea(
        child: Column(
          children: [
            _WatchlistHeader(controller: _controller),
            Expanded(
              child: Obx(() {
                final items = _controller.wishlistItems;
                final isInitialLoading =
                    _controller.isWishlistLoading.value && items.isEmpty;

                if (isInitialLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (items.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        _controller.loadWishlist(showLoading: false),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      children: const [
                        SizedBox(height: 100),
                        _EmptyWatchlistCard(),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => _controller.loadWishlist(showLoading: false),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _WatchlistTile(
                        item: item,
                        isRemoving: _controller.isDeleteInProgress(item.id),
                        onConfirmDelete: () => _confirmDelete(
                          context,
                          item.stockSymbol,
                        ),
                        onDismissed: () {
                          _controller.removeWishlistItem(
                            item.id,
                            symbol: item.stockSymbol,
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, String symbol) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
          title: const Text('Remove stock'),
          content: Text('Remove $symbol from your watchlist?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
            ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                
                backgroundColor: Colors.red),
              child: const Text(
                'Remove',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}

class _WatchlistHeader extends StatelessWidget {
  final StockDetailsController controller;

  const _WatchlistHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xff0A0A8F),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Watchlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Track your saved stocks in one place.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x1FFFFFFF),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: const Color(0x33FFFFFF)),
              ),
              child: Text(
                '${controller.wishlistItems.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WatchlistTile extends StatelessWidget {
  final WishlistItem item;
  final bool isRemoving;
  final Future<bool> Function() onConfirmDelete;
  final VoidCallback onDismissed;

  const _WatchlistTile({
    required this.item,
    required this.isRemoving,
    required this.onConfirmDelete,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: ValueKey(item.id),
        direction:
            isRemoving ? DismissDirection.none : DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        confirmDismiss: (_) => onConfirmDelete(),
        onDismissed: (_) => onDismissed(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.05),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xff0A0A8F),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    item.normalizedSymbol.isEmpty
                        ? '?'
                        : item.normalizedSymbol[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.normalizedSymbol,
                      style: const TextStyle(
                        color: Color(0xFF101727),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatCreatedAt(item.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF667085),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isRemoving)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF98A2B3),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCreatedAt(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) {
      return 'Added recently';
    }

    final date = DateTime.tryParse(raw);
    if (date == null) {
      return 'Added recently';
    }
    return 'Added ${DateFormat('dd MMM yyyy, hh:mm a').format(date.toLocal())}';
  }
}

class _EmptyWatchlistCard extends StatelessWidget {
  const _EmptyWatchlistCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(
            Icons.favorite_border_rounded,
            color: Color(0xFF98A2B3),
            size: 38,
          ),
          SizedBox(height: 10),
          Text(
            'No stocks in watchlist yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101727),
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Tap the favorite button in stock details to add one.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
