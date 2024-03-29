import 'package:flutter/material.dart';
import 'package:news_app/provider/language_provider.dart';
import 'package:news_app/utils/app_language.dart';
import 'package:news_app/utils/colors_app.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String selectLanguage = "en";
  late LanguageProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 29),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.getLocalizations.language, style: TextStyle()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 18),
                  child: buildLanguageDropDownButton(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLanguageDropDownButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.appBarBackground)),
      child: DropdownButton<String>(
        items: const [
          DropdownMenuItem(
              value: "en",
              child: Text("English",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.appBarBackground))),
          DropdownMenuItem(
              value: "ar",
              child: Text("العربيه",
                  style: TextStyle(
                      fontSize: 14, color: AppColors.appBarBackground))),
        ],
        value: selectLanguage,
        isExpanded: true,
        onChanged: (newValue) {
          selectLanguage = newValue!;
          provider.setCurrentLocale(selectLanguage);
          setState(() {});
        },
      ),
    );
  }
}
