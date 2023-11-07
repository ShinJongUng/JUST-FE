import 'package:dio/dio.dart';
import 'package:just/getX/login_controller.dart';
import 'package:get/get.dart' as Get;

import 'package:just/models/comment_model.dart';
import 'package:just/utils/dio_options.dart';

Future<List<Comment>> getComments(int postId) async {
  final dio = Dio(DioOptions().options);
  final LoginController lc = Get.Get.put(LoginController());

  dio.options.headers["Authorization"] = "Bearer ${lc.accessToken}";
  final response = await dio.get('/get/$postId/comments');

  if (response.statusCode == 200) {
    List<dynamic> jsonComments = response.data["comments"];
    Map<int, Comment> commentsMap = {};

    for (var jsonComment in jsonComments) {
      if (jsonComment['parent'] != null) {
        var parentJson = jsonComment['parent'];
        int parentId = parentJson['comment_id'];

        Comment parentComment = commentsMap.putIfAbsent(
          parentId,
          () => Comment(
            commentId: parentId,
            username: '익명',
            timestamp: DateTime.parse(parentJson['comment_create_time']),
            text: parentJson['comment_content'],
            replies: [],
          ),
        );
        Comment replyComment = Comment(
          commentId: jsonComment['comment_id'],
          username: '익명',
          timestamp: DateTime.parse(jsonComment['comment_create_time']),
          text: jsonComment['comment_content'],
          replies: [],
        );

        parentComment.replies!.add(replyComment);
      } else {
        commentsMap.putIfAbsent(
          jsonComment['comment_id'],
          () => Comment(
            commentId: jsonComment['comment_id'],
            username: '익명',
            timestamp: DateTime.parse(jsonComment['comment_create_time']),
            text: jsonComment['comment_content'],
            replies: [],
          ),
        );
      }
    }

    return commentsMap.values.toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
