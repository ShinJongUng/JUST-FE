import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/models/post_arguments.dart';
import 'package:just/utils/format_iso_string.dart';

class UserPostWidget extends StatelessWidget {
  final String title;
  final List<String> postContents;
  final int numbersOfComments;
  final int numbersOfLikes;
  final String timeString;
  final int bgImageId;
  final int postId;
  final bool like;

  const UserPostWidget(
      {super.key,
      required this.postId,
      required this.title,
      required this.numbersOfComments,
      required this.numbersOfLikes,
      required this.timeString,
      required this.bgImageId,
      required this.postContents,
      required this.like});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/single-post',
          arguments: PostArguments(
            postId: postId,
            bgImageId: bgImageId,
            pagesText: postContents,
            numbersOfComments: numbersOfComments,
            numbersOfLikes: numbersOfLikes,
            like: like,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Row(children: [
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      title,
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
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.comment,
                                size: 17,
                              ),
                              Text('$numbersOfComments'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                size: 17,
                              ),
                              Text('$numbersOfLikes'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Image.asset(
                'assets/background/background$bgImageId.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
