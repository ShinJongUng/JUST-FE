import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/models/post_arguments.dart';
import 'package:just/utils/format_iso_string.dart';

class UserCommentWidget extends StatelessWidget {
  final String comments;
  final List<String> postContents;
  final List<String> postTags;
  final int numbersOfComments;
  final int numbersOfLikes;
  final String timeString;
  final int bgImageId;
  final int postId;
  final bool like;

  const UserCommentWidget(
      {super.key,
      required this.comments,
      required this.postId,
      required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.timeString,
      required this.bgImageId,
      required this.postContents,
      required this.postTags,
      required this.like});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/single-post',
          arguments: PostArguments(
            postId: postId,
            bgImageId: bgImageId,
            pagesText: postContents,
            postTags: postTags,
            numbersOfComments: numbersOfComments,
            numbersOfLikes: numbersOfLikes,
            like: like,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: SizedBox(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  comments,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      parseAndFormatIso8601String(timeString),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
