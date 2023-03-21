import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPostWidget extends StatelessWidget {
  final String title;
  final int numberOfComments;
  final int numberOfLikes;

  const UserPostWidget(
      {super.key,
      required this.title,
      required this.numberOfComments,
      required this.numberOfLikes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/post'),
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
                              Text('$numberOfComments'),
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
                              Text('$numberOfLikes'),
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
              child: Image.network(
                'https://picsum.photos/200/300',
                fit: BoxFit.cover,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
