import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just/models/post_arguments.dart';

class UserPostWidget extends StatelessWidget {
  final String title;
  final int numbersOfComments;
  final int numbersOfLikes;

  const UserPostWidget(
      {super.key,
      required this.title,
      required this.numbersOfComments,
      required this.numbersOfLikes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/single-post',
          arguments: PostArguments(
            bgImageId: 1,
            pagesText: ['ddddddd', 'ddddddd'],
            numbersOfComments: numbersOfComments,
            numbersOfLikes: numbersOfLikes,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Row(children: [
            Expanded(
              child: Container(
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
                          DateFormat('yyyy.MM.dd').format(DateTime.now()),
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
                'assets/test1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
