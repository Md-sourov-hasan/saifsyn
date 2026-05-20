import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class SearchBar extends StatefulWidget {
  final Function(String)? onSearchChanged;

  const SearchBar({super.key, this.onSearchChanged});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Container(
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
          Icon(
            Icons.search,
            color: const Color(0xFF99A1AF),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                if (widget.onSearchChanged != null) {
                  widget.onSearchChanged!(value);
                }
              },
              decoration: InputDecoration(
                hintText: localizationService.translate('searchStocks'),
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
                color: const Color(0xFF0E162B),
                fontSize: 16.sp,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
