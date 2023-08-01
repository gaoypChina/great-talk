import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_talk/common/doubles.dart';
// packages
import 'package:cached_network_image/cached_network_image.dart';
import 'package:great_talk/common/persons.dart';
import 'package:great_talk/model/chat_content/chat_content.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({Key? key, required this.chatUser}) : super(key: key);
  final ChatContent chatUser;
  @override
  Widget build(BuildContext context) {
    final imageUrl = chatUser.imageUrl;
    final length = userImageSize(context);
    final isOriginalContent = returnIsOriginalContents(chatUser.posterUid);
    return imageUrl.isEmpty
        ? const Icon(Icons.person)
        : InkWell(
            onTap: () {
              if (!isOriginalContent) {
                Get.toNamed('/users/${chatUser.posterUid}');
              }
            },
            child: SizedBox(
              width: length,
              height: length,
              child: CachedNetworkImage(
                imageBuilder: (context, image) {
                  return Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: image, fit: BoxFit.fill)),
                  );
                },
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              ),
            ),
          );
  }
}
