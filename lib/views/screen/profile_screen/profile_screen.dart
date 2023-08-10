import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:great_talk/controllers/current_user_controller.dart';
import 'package:great_talk/controllers/profile_controller.dart';
import 'package:great_talk/mixin/current_uid_mixin.dart';
import 'package:great_talk/views/components/circle_image.dart';
import 'package:great_talk/views/screen/profile_screen/components/edit_button.dart';
import 'package:great_talk/views/screen/profile_screen/components/follow_button.dart';
import 'package:great_talk/views/screen/refresh_screen/refresh_screen.dart';

class ProfileScreen extends StatelessWidget with CurrentUserMixin {
  const ProfileScreen({Key? key, required this.controller}) : super(key: key);
  final ProfileController controller;
  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Row(
        children: [
          Obx(
            () => controller.passiveUser.value == null
                ? const SizedBox.shrink()
                : CircleImage(
                    bucketName: controller.passiveUser.value!
                        .typedUserImage()
                        .bucketName,
                    imageValue:
                        controller.passiveUser.value!.typedUserImage().value),
          ),
          Column(
            children: [
              Row(
                children: [
                  Obx(() => Text(controller.passiveUid() == currentUid()
                      ? "フォロー ${CurrentUserController.to.followingUids.length}"
                      : "フォロー ${controller.passiveUser.value?.followingCount ?? 0}")),
                  Obx(() => Text(
                      "フォロワー ${controller.passiveUser.value?.followerCount ?? 0}"))
                ],
              ),
              Row(
                children: [
                  Obx(() => Text(
                      controller.passiveUser.value!.typedUserName().value)),
                  InkWell(
                    onTap: () => Get.toNamed(
                        "/users/${controller.passiveUid()}/posts/search"),
                    child: const Icon(Icons.search),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      Obx(() => Align(
            alignment: Alignment.centerLeft,
            child: Text(controller.passiveUser.value!.typedBio().value),
          )),
    ];
    return Obx(() => Column(
          children: [
            controller.isMyProfile ? const EditButton() : const FollowButton(),
            if (controller.passiveUser.value != null) ...children,
            Expanded(
                // ここで初期化している
                child: RefreshScreen(
              docsController: controller,
            ))
          ],
        ));
  }
}
