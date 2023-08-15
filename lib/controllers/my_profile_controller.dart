import 'dart:io';
import 'package:get/get.dart';
import 'package:great_talk/common/ui_helper.dart';
import 'package:great_talk/controllers/abstract/profile_controller.dart';
import 'package:great_talk/mixin/current_uid_mixin.dart';
import 'package:great_talk/model/public_user/public_user.dart';
import 'package:great_talk/utility/file_utility.dart';
import 'package:great_talk/utility/new_content.dart';

class MyProfileController extends ProfileController with CurrentUserMixin {
  MyProfileController() : super(true);
  static MyProfileController get to => Get.find<MyProfileController>();
  String bio = '';
  String userName = '';
  final Rx<File?> uploadFile = Rx(null);

  Future<void> createUserUpdateLog(String imageUrl) async {
    final uid = currentUid();
    final newUserUpdateLog = NewContent.newUserUpdateLog(
        bio, userName, uid, imageUrl, currentUserRef());
    final result =
        await repository.createUserUpdateLog(uid, newUserUpdateLog.toJson());
    result.when(success: (_) {
      UIHelper.showFlutterToast("情報が更新されました");
    }, failure: () {
      UIHelper.showErrorFlutterToast("情報が更新できませんでした");
    });
  }

  Future<void> updateProfileUserState(PublicUser result) async {
    passiveUser(result);
    final s3Image = await FileUtility.getS3Image(
        result.typedImage().bucketName, result.typedImage().value);
    uint8list(s3Image);
  }
}
