import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:great_talk/controllers/purchases_controller.dart';
import 'package:great_talk/views/components/basic_height_box.dart';
import 'package:great_talk/views/components/price_list.dart';

import 'package:great_talk/views/components/product_list.dart';
import 'package:great_talk/views/main/subscribe/components/plan_descriptions.dart';
import 'package:great_talk/views/main/subscribe/components/privacy_policy_button.dart';
import 'package:great_talk/views/main/subscribe/components/restore_button.dart';

class SubscribeScreen extends StatelessWidget {
  SubscribeScreen({Key? key}) : super(key: key);
  final PurchasesController purchasesController = PurchasesController.to;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PlanDescriptions(),
          const ProductList(),
          const RestoreButton(),
          const BasicHeightBox(),
          const PrivacyPolicyButton(),
          if (Platform.isAndroid && PurchasesController.to.products.isEmpty)
            const PriceList(),
          Obx((() {
            if (purchasesController.purchasePending.value) {
              return const Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.3,
                    child: ModalBarrier(dismissible: false, color: Colors.grey),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }))
        ],
      ),
    );
  }
}
