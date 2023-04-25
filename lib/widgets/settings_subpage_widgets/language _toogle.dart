import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

enum LanguageLabel {
  russian('Русский' , "ru"),
  english('English' , "en"),
  systme('Системный' , "sys");

  const LanguageLabel(this.label , this.value);
  final String label;
  final String value;
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
      // enableSearch: false,
      initialSelection: LanguageLabel.russian,
     controller: null,
      leadingIcon: const Icon(Icons.language),
      label: const Text('Язык'),
      dropdownMenuEntries: languageEntries,
      onSelected: (language) {print(language?.value);},
    );
  }
}
