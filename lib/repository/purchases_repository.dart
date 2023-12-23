import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:great_talk/common/ui_helper.dart';
import 'package:great_talk/consts/debug_constants.dart';
import 'package:great_talk/consts/env_keys.dart';
import 'package:great_talk/controllers/current_user_controller.dart';
import 'package:great_talk/extensions/purchase_details_extension.dart';
import 'package:great_talk/iap_constants/mock_product_list.dart';
import 'package:great_talk/model/receipt_response/receipt_response.dart';
import 'package:great_talk/repository/result.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasesRepository {
  FutureResult<List<ProductDetails>> queryProductDetails(
      InAppPurchase inAppPurchase, Set<String> identifiers) async {
    if (isUseMockData) {
      return Result.success(myProductList);
    }
    try {
      final ProductDetailsResponse productDetailResponse =
          await inAppPurchase.queryProductDetails(identifiers);
      if (productDetailResponse.error != null) {
        return const Result.failure();
      } else {
        return Result.success(productDetailResponse.productDetails);
      }
    } catch (e) {
      return const Result.failure();
    }
  }

  FutureResult<bool> buyNonConsumable(
      InAppPurchase inAppPurchase, PurchaseParam purchaseParam) async {
    try {
      await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      return const Result.success(true);
    } catch (e) {
      return const Result.failure();
    }
  }

  FutureResult<ReceiptResponse> getAndroidReceipt(
      PurchaseDetails purchaseDetails, String currentUid) async {
    final instance = dio.Dio();
    Map<String, dynamic>? data;
    try {
      final dio.Response<Map<String, dynamic>> res =
          await instance.post(dotenv.get(EnvKeys.VERIFY_ANDROID_ENDPOINT.name),
              data: {
                "data": purchaseDetails.toJson(),
                "uid": currentUid,
              },
              options: dio.Options(method: "POST"));
      data = res.data;
      if (data == null || res.statusCode != 200) {
        return const Result.failure();
      } else {
        final result = ReceiptResponse.fromJson(data);
        return Result.success(result);
      }
    } catch (e) {
      if (CurrentUserController.to.isAdmin()) {
        UIHelper.showErrorFlutterToast("Androidのレシート検証が失敗しました ${e.toString()}");
      }
      return const Result.failure();
    }
  }

  FutureResult<ReceiptResponse> getIOSReceipt(
      String token, String currentUid) async {
    final instance = dio.Dio();
    Map<String, dynamic>? data;
    try {
      final dio.Response<Map<String, dynamic>> res =
          await instance.post(dotenv.get(EnvKeys.VERIFY_IOS_ENDPOINT.name),
              data: {
                "data": token,
                "uid": currentUid,
              },
              options: dio.Options(method: "POST"));
      data = res.data;
      if (data == null || res.statusCode != 200) {
        return const Result.failure();
      } else {
        final result = ReceiptResponse.fromJson(data);
        return Result.success(result);
      }
    } catch (e) {
      if (CurrentUserController.to.isAdmin()) {
        UIHelper.showErrorFlutterToast("iOSのレシート検証が失敗しました ${e.toString()}");
      }
      return const Result.failure();
    }
  }

  Future<void> restorePurchases(InAppPurchase inAppPurchase) async {
    try {
      await inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
