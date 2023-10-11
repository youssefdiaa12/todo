import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/Common/Provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  String s1 = 'Dark';
  String s2 = 'Light';

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    s1 = obj.currenttheme == ThemeMode.dark ? 'Dark' : 'Light';
    s2 = obj.currenttheme == ThemeMode.light ? 'Dark' : 'Light';
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (s1 == 'Dark') {
                obj.changetheme(ThemeMode.dark);
              } else {
                obj.changetheme(ThemeMode.light);
              }
            },
            child: selectedButton(s1),
          ),
          const SizedBox(height: 5),
          InkWell(
              onTap: () {
                if (s2 == 'Light') {
                  s1 = 'Light';
                  s2 = 'Dark';
                  obj.changetheme(ThemeMode.light);
                } else {
                  s1 = 'Dark';
                  s2 = 'Light';
                  obj.changetheme(ThemeMode.dark);
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
