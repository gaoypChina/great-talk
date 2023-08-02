import 'package:flutter/material.dart';
import 'package:great_talk/views/screen/svg_and_msg_screen.dart';

class LogoutedPage extends StatelessWidget {
  const LogoutedPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SvgAndMsgScreen(
        title: "ログアウト",
        msg: "ログアウトしました\n\nお疲れ様でした",
        svgPath: "assets/svgs/coffee_break_pana.svg");
  }
}
