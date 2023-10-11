import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/Common/Provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheet();
}

class _LanguageBottomSheet extends State<LanguageBottomSheet> {
  bool is_selected = false;
  String s1 = '';
  String s2 = 'العربيه';

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    s1 = obj.lang;
    s2 = obj.lang == 'العربيه' ? 'English' : 'العربيه';
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                obj.changeLanguage(s1);
              },
              child: selectedButton(s1)),
          const SizedBox(height: 5),
          InkWell(
              onTap: () {
                if (s2 == 'English') {
                  s2 = 'العربيه';
                  s1 = 'English';
                  obj.changeLanguage('English');
                } else {
                  is_selected = true;
                  obj.changeLanguage('العربيه');
                  s1 = 'العربيه';
                  s2 = 'English';
                }
              },
              child: unselectedButton(s2)),
        ],
      ),
    );
  }

  Widget selectedButton(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
        ),
        Icon(Icons.check, color: Theme.of(context).colorScheme.onSecondary),
      ],
    );
  }

  Widget unselectedButton(String text) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
