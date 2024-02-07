import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just/getX/post_controller.dart';
import 'package:just/views/widgets/story_page/story_builder_widget.dart';
import 'package:just/views/widgets/story_page/story_more.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late final PostController postController;
  final PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    super.initState();
    postController = Get.find();
    _pageController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_pageController.page! >= postController.posts.length - 2) {
      if (!postController.isLoading && postController.hasNextPage) {
        postController.fetchPosts();
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_scrollListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('글'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/search');
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return const StoryMore();
                },
              );
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(() {
        if (postController.posts.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.greenAccent,
          ));
        }

        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return StoryBuilderWidget(
              key: ValueKey(post.postId),
              storyType: "multiple",
              postId: post.postId,
              isLike: post.like,
              numbersOfComments: post.commentCount,
              numbersOfLikes: post.likeCount,
              bgImageId: post.postPicture,
              pagesText: post.postContents,
            );
          },
        );
      }),
    );
  }
}
