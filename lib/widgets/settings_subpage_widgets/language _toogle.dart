import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

enum LanguageLabel {
  russian('Русский', Icons.sentiment_satisfied_outlined),
  english('English', Icons.cloud_outlined),
  systme('Системный', Icons.brush_outlined);

  const LanguageLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

class LanguageToogle extends StatelessWidget {
  LanguageToogle({super.key});
  final TextEditingController iconController = TextEditingController();
  LanguageLabel? selectedIcon = LanguageLabel.russian;

  final List<DropdownMenuEntry<LanguageLabel>> languageEntries = LanguageLabel
      .values
      .map((language) => DropdownMenuEntry<LanguageLabel>(
          value: language, label: language.label))
      .toList();

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<LanguageLabel>(
      width: context.width / 1.5,
      enableSearch: true,
      initialSelection: LanguageLabel.russian,
      controller: iconController,
      leadingIcon: const Icon(Icons.language),
      label: const Text('Язык'),
      dropdownMenuEntries: languageEntries,
      onSelected: (icon) {},
    );
  }
}
