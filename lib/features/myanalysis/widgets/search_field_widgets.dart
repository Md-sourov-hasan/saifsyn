import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFieldWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const SearchFieldWidget({super.key, this.onChanged, this.onClear});

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors matching your Financial Manager
    const Color primaryBlue = Color(0xFF00008B);
    const Color borderGray = Color(0xFFE2E8F0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 52.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        // Professional dynamic border
        border: Border.all(
          color: _isFocused ? primaryBlue : borderGray,
          width: _isFocused ? 1.5 : 1.0,
        ),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: primaryBlue.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: _textController,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: 15.sp,
            color: const Color(0xFF1E293B),
            fontWeight: FontWeight.w500,
          ),
          cursorColor: primaryBlue,
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search stocks, assets, or trends...",
            hintStyle: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: _isFocused ? primaryBlue : Colors.blueGrey[400],
              size: 22.sp,
            ),
            suffixIcon: _textController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.cancel_rounded, color: Colors.blueGrey[200], size: 18.sp),
                    onPressed: () {
                      _textController.clear();
                      if (widget.onChanged != null) widget.onChanged!('');
                      if (widget.onClear != null) widget.onClear!();
                      setState(() {});
                    },
                  )
                : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
      ),
    );
  }
}