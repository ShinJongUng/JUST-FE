import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(children: [
          SizedBox(
            width: 100,
            child: Image.network(
              'https://picsum.photos/200/300',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.comment),
                            Text('$numberOfComments'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.favorite),
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
          ),
        ]),
      ),
    );
  }
}
