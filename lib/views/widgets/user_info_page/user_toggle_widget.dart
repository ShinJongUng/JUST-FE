import 'package:flutter/material.dart';
import 'package:just/models/post_model.dart';
import 'package:just/models/post_with_comment_model.dart';
import 'package:just/services/get_my_comments_posts.dart';
import 'package:just/services/get_my_like_posts.dart';
import 'package:just/services/get_my_posts.dart';
import 'package:just/views/widgets/user_info_page/user_comment_widget.dart';
import 'package:just/views/widgets/user_info_page/user_post_widget.dart';
import 'package:sticky_headers/sticky_headers.dart';

class UserToggleWidget extends StatefulWidget {
  const UserToggleWidget({super.key});

  @override
  State<UserToggleWidget> createState() => _UserToggleWidgetState();
}

class _UserToggleWidgetState extends State<UserToggleWidget>
    with TickerProviderStateMixin {
  late Future<List<Post>>? myPostsFuture;
  late Future<List<Post>>? myLikePostsFuture;
  late Future<List<PostWithComment>>? myCommentPostsFuture;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    myPostsFuture = getMyPosts();
    myLikePostsFuture = getMyLikePosts();
    myCommentPostsFuture = getMyCommentPosts();
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        color: const Color.fromARGB(255, 28, 27, 31),
        child: TabBar(
            controller: _tabController,
            labelColor: Colors.greenAccent,
            indicatorColor: Colors.greenAccent,
            tabs: [
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  '작성 글',
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  '작성 댓글',
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: const Text(
                  '좋아요한 글',
                ),
              ),
            ]),
      ),
      content: SizedBox(
        child: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                FutureBuilder<List<Post>>(
                  future: myPostsFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      )));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(bottom: 30.0),
                            key: const PageStorageKey('my_posts'),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Post post = snapshot.data![index];
                              return UserPostWidget(
                                like: post.like,
                                postId: post.postId,
                                title: post.postContents[0].length <= 10
                                    ? post.postContents[0]
                                    : post.postContents[0]
                                        .trim()
                                        .substring(0, 10),
                                postContents: post.postContents,
                                numbersOfComments: post.commentCount,
                                numbersOfLikes: post.likeCount,
                                timeString: post.postCreateTime,
                                bgImageId: post.postPicture,
                              );
                            }),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            Column(
              children: [
                FutureBuilder<List<PostWithComment>>(
                  future: myCommentPostsFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PostWithComment>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      )));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(bottom: 30.0),
                              key: const PageStorageKey('user_comments'),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                PostWithComment commentPost =
                                    snapshot.data![index];
                                return UserCommentWidget(
                                  like: commentPost.post.like,
                                  postId: commentPost.post.postId,
                                  comments:
                                      commentPost.commentContent.length <= 10
                                          ? commentPost.commentContent
                                          : commentPost.commentContent
                                              .trim()
                                              .substring(0, 10),
                                  postContents: commentPost.post.postContents,
                                  numbersOfComments:
                                      commentPost.post.commentCount,
                                  numbersOfLikes: commentPost.post.likeCount,
                                  timeString: commentPost.post.postCreateTime,
                                  bgImageId: commentPost.post.postPicture,
                                );
                              }));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            Column(
              children: [
                FutureBuilder<List<Post>>(
                  future: myLikePostsFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      )));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(bottom: 30.0),
                            key: const PageStorageKey('my_posts'),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Post post = snapshot.data![index];
                              return UserPostWidget(
                                like: post.like,
                                postId: post.postId,
                                title: post.postContents[0].length <= 10
                                    ? post.postContents[0]
                                    : post.postContents[0]
                                        .trim()
                                        .substring(0, 10),
                                postContents: post.postContents,
                                numbersOfComments: post.commentCount,
                                numbersOfLikes: post.likeCount,
                                timeString: post.postCreateTime,
                                bgImageId: post.postPicture,
                              );
                            }),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
