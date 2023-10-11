import 'package:flutter/material.dart';
import 'package:todo/task.dart';
import 'package:todo/ui/settings/List/ListTaps.dart';
import 'package:todo/ui/settings/SettingsTaps.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  static const String routname = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape:  StadiumBorder(
            side: BorderSide(width: 4, color:obj.currenttheme==ThemeMode.light?Colors.white:Color(0xff141922))),
        onPressed: () {
          setState(() {
            showAddTask();
          });
        },
        child: const Icon(Icons.add,color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color:obj.currenttheme==ThemeMode.light?Colors.white:Color(0xff141922),
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              obj.selectedindex = index;
            });
          },
          currentIndex:   obj.selectedindex ,
          items: const [
            BottomNavigationBarItem(icon: (Icon(Icons.list)), label: ''),
            BottomNavigationBarItem(icon: (Icon(Icons.settings)), label: '')
          ],
        ),
      ),
      body: tabs[ obj.selectedindex ],
    );
  }

  var tabs = [ListTaps(), const SettingsTaps()];

  void showAddTask() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return task(AppLocalizations.of(context)!.addNewTask,'Task added successfully',is_add: true,);
        }

        );
  }
}
