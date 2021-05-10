import 'package:flutter/material.dart';
import 'classes/language.dart';
import 'main.dart';

class LangSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _changelanguage(Language language) {
      Locale _temp;
      switch (language.languageCode) {
        case 'ur':
          _temp = Locale(language.languageCode, 'PK');
          break;
        case 'en':
          _temp = Locale(language.languageCode, 'US');
          break;
        default:
          _temp = Locale(language.languageCode, 'PK');
          break;
      }
      MyApp.setLocale(context, _temp);
    }

    return DropdownButton(
      onChanged: _changelanguage,
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.white,
      ),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(lang.flag),
                    Text(
                      lang.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }
}
