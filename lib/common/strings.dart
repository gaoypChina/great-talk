// packages
import 'package:great_talk/model/chat_user_metadata/chat_user_metadata.dart';
import 'package:great_talk/iap_constants/subscription_constants.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

String randomString() {
  const uuid = Uuid();
  return uuid.v4();
}

String getName(types.User person) => person.lastName ?? 'UNKNOWN';

// prefs_key
// personIdで各々のChat履歴
const lastChatDatePrefsKey = "lastChatDate";
const chatCountPrefsKey = "chatCount";
const isAgreedToTermsPrefsKey = "isAgreedToTerms";
const localPersonsPrefsKey = "localPersons";
const professionalsPrefsKey = "professionals";
String getPlanDescription(String productID, String price) {
  String msg = "";
  switch (productID) {
    case (kAnnualSubscriptionId):
      msg = "1年";
      break;
    case (kMonthSubscriptionId):
      msg = "1ヶ月";
      break;
    case (kWeekSubscriptionId):
      msg = "1週間";
      break;
  }
  msg += "あたり$priceです。";
  return msg;
}

String getPlanName(ProductDetails productDetails) {
  String msg = "";
  switch (productDetails.id) {
    case (kAnnualSubscriptionId):
      msg = "年額";
      break;
    case (kMonthSubscriptionId):
      msg = "月額";
      break;
    case (kWeekSubscriptionId):
      msg = "週額";
      break;
  }
  msg += "プラン";
  return msg;
}

String? mapMetadataToLastAnswer(Map<String, dynamic>? mapMetadata) =>
    mapMetadata == null
        ? null
        : ChatUserMetadata.fromJson(mapMetadata).lastAnswer;
const String appName = "すごいAI";
// msg
const String clearChatMsg = "チャット履歴を全て削除しました";
const String calculateFailedMsg = '計算結果が取得できませんでした';
const String wrongInfoMsg = """
注意
AIからの返事は誤った内容が含まれることがあります。
あくまでエンターテイメントとしてご利用ください。
ご理解のほどよろしくお願いいたします。
""";
// text
const String tosText = "利用規約";
const String agreeText = "同意する";
const iosData = "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";
