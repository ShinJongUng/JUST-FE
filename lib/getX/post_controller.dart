// post_controller.dart
import 'package:get/get.dart';
import 'package:just/models/post_model.dart';
import 'package:just/services/get_posts.dart';
import 'package:just/services/post_post_like.dart';

class PostController extends GetxController {
  final RxList<int> viewedPosts = <int>[].obs;
  final RxList<Post> posts = <Post>[].obs;
  final RxBool _isLoading = false.obs;
  bool _hasNextPage = true;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() async {
    if (!_hasNextPage || _isLoading.value) return;
    _isLoading.value = true;
    final PostsResponse? newPostsResponse = await getPosts(5, viewedPosts);
    if (newPostsResponse != null && newPostsResponse.mySlice.isNotEmpty) {
      var newPosts = newPostsResponse.mySlice;
      posts.addAll(newPosts);
      var newPostIds = newPosts.map((post) => post.postId).toSet();
      viewedPosts.addAll(newPostIds.where((id) => !viewedPosts.contains(id)));
      _hasNextPage = newPostsResponse.hasNext;
      update();
    } else {
      _hasNextPage = false;
    }
    _isLoading.value = false;
  }

  void refreshPosts() async {
    posts.clear();
    viewedPosts.clear();
    _hasNextPage = true;
    fetchPosts();
  }

  void toggleLike(int postId, bool isLike) async {
    var postIndex = posts.indexWhere((post) => post.postId == postId);
    if (postIndex != -1) {
      posts[postIndex].like = isLike;
      await postPostLike(postId, isLike);
      isLike ? posts[postIndex].likeCount++ : posts[postIndex].likeCount--;
      posts.refresh();
    }
  }

  void increaseCommentCount(int postId) {
    var postIndex = posts.indexWhere((post) => post.postId == postId);
    if (postIndex != -1) {
      posts[postIndex].commentCount++;
      posts.refresh();
    }
  }

  bool get hasNextPage => _hasNextPage;
  bool get isLoading => _isLoading.value;
}
