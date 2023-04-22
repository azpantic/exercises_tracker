import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/i18n/strings.g.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends GetView<void> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.push("/settings/theme_setting");
              },
              icon: const Icon(Icons.palette),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.navbar.settings),
            ],
          ),
        ),
        body: const Placeholder());
  }
}
