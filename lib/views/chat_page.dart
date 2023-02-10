// flutter
import 'package:flutter/material.dart';
// packages
import 'package:get/get.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// api
import 'package:great_talk/api/chat_api.dart';
import 'package:great_talk/common/others.dart';
// common
import 'package:great_talk/common/strings.dart';
import 'package:great_talk/common/widgets.dart';
import 'package:great_talk/controllers/purchases_controller.dart';

class ChatPage extends HookWidget {
  const ChatPage({
    Key? key,
    required this.person
  }) : super(key: key);
  final types.User person;
  @override
  Widget build(context) {
    final messages = useState(<types.Message>[]);
    final String name = getName(person);
    // このページでPurchasesContollerを使用する場合は、以下の式をpurchasesに代入する.
    Get.put(PurchasesController());
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
      	messages.value = await ChatApi.getChatLog(person);
      });
      return;
    },[]);
    return Scaffold(
      appBar: AppBar(
        title: boldText(name),
        shape: appBarShape(context),
      ),
      body: Chat(
        avatarBuilder: (text) => UserAvatar(author: person),
        showUserAvatars: true,
        messages: messages.value, 
        onSendPressed: (partialText) async {
          await ChatApi.onSendPressed(context,partialText, messages, person);
        },
        user: ChatApi.user,
      ),
    );
  }
}