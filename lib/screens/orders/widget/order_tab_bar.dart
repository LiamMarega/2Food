import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderTabBar extends StatelessWidget {
  final TabController controller;

  const OrderTabBar({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'ordersPage.tabs.active'.tr()),
            Tab(text: 'ordersPage.tabs.completed'.tr()),
            Tab(text: 'ordersPage.tabs.canceled'.tr()),
          ],
          indicator: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
        ),
      ),
    );
  }
}
