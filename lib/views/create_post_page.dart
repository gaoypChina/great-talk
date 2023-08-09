import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:great_talk/controllers/create_post_controller.dart';

class CreatePostPage extends HookWidget {
  const CreatePostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreatePostController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("投稿を作成"),
        ),
        body: Column(
          children: [
            Obx(() => controller.uint8List.value == null
                ? InkWell(
                    onTap: controller.onImagePickButtonPressed,
                    child: const Icon(
                      Icons.image,
                      size: 100.0,
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Image.memory(controller.uint8List.value!),
                  )),
            InkWell(
              onTap: controller.onUploadButtonPressed,
              child: const Icon(
                Icons.upload,
                size: 100.0,
              ),
            ),
          ],
        ));
  }
}
