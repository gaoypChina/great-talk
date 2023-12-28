import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:great_talk/common/strings.dart';
import 'package:great_talk/common/ui_helper.dart';
import 'package:great_talk/controllers/abstract/loading_controller.dart';
import 'package:great_talk/controllers/purchases_controller.dart';
import 'package:great_talk/mixin/current_uid_mixin.dart';
import 'package:great_talk/model/generata_image/generate_image_request/generate_image_request.dart';
import 'package:great_talk/repository/open_ai_repository.dart';
import 'package:great_talk/views/main/subscribe/subscribe_page.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GenerateImageController extends LoadingController with CurrentUserMixin {
  static GenerateImageController get to => Get.find<GenerateImageController>();
  final rxPrompt = "".obs;
  final rxUrl = "".obs;
  // セッターメソッド
  void setPrompt(String? value) {
    if (value == null) return;
    rxPrompt.value = value;
  }

  void onGenerateButtonPressed() async {
    if (rxPrompt.value.isEmpty) {
      UIHelper.showErrorFlutterToast("プロンプトを入力してください");
      return;
    } else if (!PurchasesController.to.isPremiumSubscribing()) {
      UIHelper.showErrorFlutterToast("プレミアムプランに登録してください");
      Get.toNamed(SubscribePage.path);
    } else {
      await _generateImage();
    }
  }

  Future<void> _generateImage() async {
    if (isLoading.value) {
      await UIHelper.showErrorFlutterToast("生成中です");
      return;
    }
    startLoading();
    rxUrl(""); // 初期化
    final repository = OpenAIRepository();
    final request = GenerateImageRequest.instance(rxPrompt.value, currentUid());
    final result = await repository.generateImage(request);
    result.when(success: (res) {
      final url = res.data?.last?.url;
      rxUrl(url);
    }, failure: () {
      UIHelper.showErrorFlutterToast("画像が生成できませんでした");
    });
    endLoading();
  }

  void onImageTapped() {
    UIHelper.cupertinoAlertDialog("画像を保存しますか?", saveImage);
  }

  Future<void> saveImage() async {
    Get.back();
    startLoading();
    try {
      final imageUrl = rxUrl.value;
      final response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final name = randomString();
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: name);
      if (result.containsKey('isSuccess')) {
        UIHelper.showFlutterToast("画像を保存できました");
      }
    } catch (e) {
      UIHelper.showErrorFlutterToast("画像を保存できませんでした");
    }
    endLoading();
  }
}
