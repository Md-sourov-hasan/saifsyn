import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saifsyn/core/core.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1.w,
            color: const Color(0xFFE5E7EB),
          ),
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5.9,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          return _NavItem(
            iconPath: item.icon,
            label: item.label,
            isActive: currentIndex == index,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 64.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: isActive
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF00008B),
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        iconPath,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.none,
                      ),
                    )
                  : Image.asset(
                      iconPath,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                    ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.33,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color(0xFF00008B)
                    : const Color(0xFF99A1AE),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  final String icon;
  final String label;

  const _NavItemData(this.icon, this.label);
}

const _items = [
  _NavItemData(ImagePath.homeIcon, 'Home'),
  _NavItemData("assets/images/heart.png", 'Watchlist'),
  _NavItemData(ImagePath.stocksIcon, 'Analysis'),
  _NavItemData(ImagePath.portfolioIcon, 'Expense'),
  _NavItemData(ImagePath.profileIcon, 'Profile'),
];
