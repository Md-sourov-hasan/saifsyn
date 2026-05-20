import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class PortfolioHeader extends StatefulWidget {
  final Function(String)? onSearchChanged;

  const PortfolioHeader({super.key, this.onSearchChanged});

  @override
  State<PortfolioHeader> createState() => _PortfolioHeaderState();
}

class _PortfolioHeaderState extends State<PortfolioHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF00008B),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and notification in same row
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    localizationService.translate('portfolioStocks'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Notification icon
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0000BF),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                        // Notification badge
                        Positioned(
                          right: 8.w,
                          top: 9.h,
                          child: Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFB2C36),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Subtitle
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 4.h, bottom: 8.h),
              child: SizedBox(
                child: Text(
                  localizationService.translate('portfolioHeaderDescription'),
                  style: TextStyle(
                    color: const Color(0xFF61738D),
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ),
            ),

            // Search bar
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 12.h),
              child: Container(
                width: double.infinity,
                height: 40.h,
                padding: EdgeInsets.only(left: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF99A1AF),
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          if (widget.onSearchChanged != null) {
                            widget.onSearchChanged!(value);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: localizationService.translate('searchPortfolioStocks'),
                          hintStyle: TextStyle(
                            color: const Color(0xFF99A1AF),
                            fontSize: 16.sp,
                            fontFamily: 'Arial',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        Icons.search,
                        color: const Color(0xFF99A1AF),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
