import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/i18n/strings.g.dart';
import 'package:get/get.dart';

class ListPage extends GetView<void> {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(t.navbar.list),
        ),
        body: const Placeholder());
  }
}
