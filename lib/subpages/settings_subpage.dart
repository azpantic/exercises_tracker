import 'package:flutter/material.dart';
import 'package:flutter_mobile_application_template/constans.dart';
import 'package:flutter_mobile_application_template/controllers/main_controller.dart';
import 'package:flutter_mobile_application_template/i18n/strings.g.dart';
import 'package:flutter_mobile_application_template/widgets/settings_subpage_widgets/seed_color_toogle.dart';
import 'package:flutter_mobile_application_template/widgets/settings_subpage_widgets/theme_toogle.dart';
import 'package:get/get.dart';

import '../widgets/settings_subpage_widgets/language _toogle.dart';

class SettingsSubpage extends GetView<MainController> {
  const SettingsSubpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.title),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Padding(
            //     padding: EdgeInsets.all(appPadding),
            //     child: LanguageToogle(),
            //   ),
            Text(
              t.settings.theme_mode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(
              padding: EdgeInsets.all(appPadding),
              child: ThemeToggle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              t.settings.seed_color,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(
              padding: EdgeInsets.all(appPadding),
              child: SeedColorToogle(),
            ),
          ],
        ),
      ),
    );
  }
}
