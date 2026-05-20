import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:saifsyn/core/localization/localization_service.dart';

class Comment {
  final String name;
  final String time;
  final String text;
  int likes;
  bool isLiked;

  Comment({
    required this.name,
    required this.time,
    required this.text,
    this.likes = 0,
    this.isLiked = false,
  });
}

class CommentsSection extends StatefulWidget {
  const CommentsSection({super.key});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [
    Comment(
      name: 'Donald Rice',
      time: '5 min ago',
      text:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      likes: 25,
    ),
    Comment(
      name: 'Jane Smith',
      time: '15 min ago',
      text: 'This stock looks promising based on the recent analysis.',
      likes: 12,
    ),
    Comment(
      name: 'Mike Johnson',
      time: '1 hour ago',
      text: 'Great entry point for long-term investors!',
      likes: 8,
    ),
  ];

  void _addComment() {
    if (_commentController.text.trim().isNotEmpty) {
      setState(() {
        _comments.insert(
          0,
          Comment(
            name: 'You',
            time: 'Just now',
            text: _commentController.text.trim(),
            likes: 0,
          ),
        );
        _commentController.clear();
      });
    }
  }

  void _toggleLike(int index) {
    setState(() {
      if (_comments[index].isLiked) {
        _comments[index].likes--;
        _comments[index].isLiked = false;
      } else {
        _comments[index].likes++;
        _comments[index].isLiked = true;
      }
    });
  }

  void _showReplyDialog(int index) {
    final replyController = TextEditingController();
    final localizationService = Get.find<LocalizationService>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${localizationService.translate('replyTo')} ${_comments[index].name}',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: TextField(
          controller: replyController,
          decoration: InputDecoration(
            hintText: localizationService.translate('writeYourReply'),
            hintStyle: TextStyle(
              color: const Color(0xFF61738D),
              fontSize: 12.sp,
              fontFamily: 'Arimo',
            ),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              localizationService.translate('cancel'),
              style: TextStyle(
                color: const Color(0xFF99A1AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (replyController.text.trim().isNotEmpty) {
                setState(() {
                  _comments.insert(
                    index + 1,
                    Comment(
                      name: localizationService.translate('you'),
                      time: localizationService.translate('justNow'),
                      text:
                          '@${_comments[index].name} ${replyController.text.trim()}',
                      likes: 0,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00008B),
            ),
            child: Text(
              localizationService.translate('reply'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizationService = Get.find<LocalizationService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          localizationService.translate('comments'),
          style: TextStyle(
            color: const Color(0xFF0E162B),
            fontSize: 16.sp,
            fontFamily: 'Arimo',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),

        SizedBox(height: 6.h),

        // Comments container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: const Color(0xFFF0F4F9),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: -1,
              ),
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              // Comments list
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
                child: Column(
                  children: _comments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final comment = entry.value;
                    return Column(
                      children: [
                        if (index > 0) SizedBox(height: 35.h),
                        _buildComment(comment, index),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // Input section
              Container(
                width: double.infinity,
                height: 49.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Input field
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText:
                                localizationService.translate('typeAComment'),
                            hintStyle: TextStyle(
                              color: const Color(0xFF61738D),
                              fontSize: 12.sp,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.w400,
                              height: 1.33,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: const Color(0xFF0E162B),
                            fontSize: 12.sp,
                            fontFamily: 'Arimo',
                          ),
                          onSubmitted: (value) => _addComment(),
                        ),
                      ),
                    ),

                    // Send button
                    GestureDetector(
                      onTap: _addComment,
                      child: Container(
                        width: 76.w,
                        height: 49.h,
                        color: const Color(0xFF00008B),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20.sp,
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
      ],
    );
  }

  Widget _buildComment(Comment comment, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            border: Border.all(
              width: 1,
              color: const Color(0xFFF0F4F9),
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              comment.name[0].toUpperCase(),
              style: TextStyle(
                color: const Color(0xFF00008B),
                fontSize: 16.sp,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        SizedBox(width: 15.w),

        // Comment content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and time
              Text(
                '${comment.name} . ${comment.time} ',
                style: TextStyle(
                  color: const Color(0xFF00008B),
                  fontSize: 16.sp,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                ),
              ),

              SizedBox(height: 5.h),

              // Comment text
              Text(
                comment.text,
                style: TextStyle(
                  color: const Color(0xFF61738D),
                  fontSize: 12.sp,
                  fontFamily: 'Arimo',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),

              SizedBox(height: 4.h),

              // Reply and Like
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _showReplyDialog(index),
                    child: Text(
                      Get.find<LocalizationService>().translate('reply'),
                      style: TextStyle(
                        color: const Color(0xFF99A1AF),
                        fontSize: 13.sp,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.w400,
                        height: 1.85,
                      ),
                    ),
                  ),
                  SizedBox(width: 28.w),
                  GestureDetector(
                    onTap: () => _toggleLike(index),
                    child: Text(
                      Get.find<LocalizationService>().translate('like'),
                      style: TextStyle(
                        color: comment.isLiked
                            ? const Color(0xFFFB2C36)
                            : const Color(0xFF99A1AF),
                        fontSize: 13.sp,
                        fontFamily: 'Arimo',
                        fontWeight:
                            comment.isLiked ? FontWeight.w700 : FontWeight.w400,
                        height: 1.85,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (comment.likes > 0)
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: const Color(0xFFFB2C36),
                          size: 12.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${comment.likes}',
                          style: TextStyle(
                            color: const Color(0xFFFB2C36),
                            fontSize: 13.sp,
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.w400,
                            height: 1.85,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
