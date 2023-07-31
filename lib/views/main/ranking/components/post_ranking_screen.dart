import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_talk/controllers/post_ranking_controller.dart';
import 'package:great_talk/model/post/post.dart';
import 'package:great_talk/views/components/refresh_screen.dart';

class PostRankingScreen extends StatelessWidget {
  const PostRankingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostRankingController());
    return Obx(() => RefreshScreen(
        docsController: controller,
        child: ListView.builder(
            itemCount: controller.docs.length,
            itemBuilder: (c, i) {
              final post = Post.fromJson(controller.docs[i].data());
              return Text(post.postId);
            })));
  }
}
