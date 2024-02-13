import 'package:flutter/material.dart';
import 'package:just/models/post_arguments.dart';
import 'package:just/views/widgets/story_page/story_builder_widget.dart';

class SinglePostPage extends StatelessWidget {
  const SinglePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    PostArguments arguments =
        ModalRoute.of(context)?.settings.arguments as PostArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: StoryBuilderWidget(
          storyType: "single",
          postId: arguments.postId,
          isLike: arguments.like,
          postTags: arguments.postTags,
          numbersOfComments: arguments.numbersOfComments,
          numbersOfLikes: arguments.numbersOfLikes,
          bgImageId: arguments.bgImageId,
          pagesText: arguments.pagesText),
    );
  }
}
