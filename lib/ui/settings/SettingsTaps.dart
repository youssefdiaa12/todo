import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/Common/LanguageBottomSheet.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/Common/ThemeBottomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTaps extends StatefulWidget {
  static const String routname='SettingsTaps';

  const SettingsTaps({Key? key}) : super(key: key);

  @override
  State<SettingsTaps> createState() => _SettingsTapsState();
}

class _SettingsTapsState extends State<SettingsTaps> {
  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top:33,left:62),
            child: Text(AppLocalizations.of(context)!.settings,style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.start,),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
              margin: const EdgeInsets.only(left: 12,right: 12),
              child:  Text(AppLocalizations.of(context)!.mode,style: Theme.of(context).textTheme.titleMedium)),
          InkWell(
            onTap: () {
              ShowThemeBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12, left: 12),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          obj.currenttheme == ThemeMode.light ? 'Light' : 'Dark',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_downward_rounded,color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.only(left: 12,right: 12),
              child:  Text(AppLocalizations.of(context)!.lang,style: Theme.of(context).textTheme.titleMedium,textDirection: TextDirection.rtl,)),
          InkWell(
            onTap: () {
              ShowLanguageBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12, left: 12),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onSecondary,
                  )),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(obj.lang, style: Theme.of(context).textTheme.bodyMedium),
                  )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_downward_rounded,color: Colors.blue),
                  ),

                ],
              ),
            ),
          )
        ],
      ),

    );
  }
  void ShowLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
    );
  }

  void ShowThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeBottomSheet();
      },
    );
  }

}


