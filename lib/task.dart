import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/database/model/task_id.dart';
import 'package:todo/ui/Common/CustonFormField.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/Common/tasksProvider.dart';
import 'package:todo/ui/settings/List/ListTaps.dart';
import 'package:todo/ui/settings/SettingsTaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:todo/ui/Common/dialogUtilites.dart';

class task extends StatefulWidget {

 String title;
 String showmsg;
 task1 ?tskia;
 bool is_add;
 task(this.title,this.showmsg, {super.key, this.tskia,required this.is_add});
  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  TextEditingController Title = TextEditingController();

  TextInputType a2 = TextInputType.text;

  TextEditingController Description = TextEditingController();

  TextInputType a3 = TextInputType.text;

  var keyform = GlobalKey<FormState>();
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    return Scaffold(
      backgroundColor: obj.currenttheme==ThemeMode.light?Colors.white:Colors.black54,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape:  StadiumBorder(
              side: BorderSide(width: 4, color:obj.currenttheme==ThemeMode.light?Colors.white:const Color(0xff141922))),
          onPressed: () {
            taskValidation(widget.is_add);
            setState(() {
              if (selectedDate == null) {
                isVisible = true;
              } else {
                isVisible = false;
              }
            });
          },
          child: const Icon(Icons.done,color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:obj.currenttheme==ThemeMode.light?Colors.white:const Color(0xff141922),
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index) {
            setState(() {
              obj.selectedindex = index;
              Navigator.pop(context);
              obj.changeVisability();
            });
          },
          currentIndex: obj.selectedindex,
          items: const [
            BottomNavigationBarItem(icon: (Icon(Icons.list)), label: ''),
            BottomNavigationBarItem(icon: (Icon(Icons.settings)), label: '')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: keyform,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
               Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: obj.currenttheme==ThemeMode.light?Colors.blue:Colors.white),
          ),
              )),
              Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child: CustomFormField(Title,AppLocalizations.of(context)!.title,a2, false, (p0) {
            if (p0 == null || p0.isEmpty) {
              return 'Please enter your title';
            }
            return null;
          }),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
          child:
              CustomFormField(Description,AppLocalizations.of(context)!.description, a3, false, (pp0) {
            if (pp0 == null || pp0.isEmpty) {
              return 'Please enter your Description';
            }
            return null;
          }, lines: 4),
              ),
              Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
          child: InkWell(
              onTap: () {
                showTaskDate();
              },
              child: selectedDate != null
                  ? Text(
                      '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',style: TextStyle(color:obj.currenttheme==ThemeMode.light?Colors.black:Colors.blue),)
                  : Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).primaryColor,
                ),
                      child: Row(
                        children: [
                           Expanded(
                             child: Container(
                               height: 45,
                                 child:   Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                                   child: Text(AppLocalizations.of(context)!.selectDate,style:const TextStyle(fontSize: 20,color:Colors.white,fontWeight: FontWeight.w500) ,),
                                 )),
                           ),
                          const Icon(Icons.arrow_forward_outlined,color: Colors.white),
                          const SizedBox(width: 30,)



                        ],
                      ),
                    ),
                  )),
              ),
              Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Visibility(
            visible: isVisible,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:3.0,right: 8.0),
                  child: Container(
                    height:1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffb32f2f),
                    )
                  ),
                ),
                SizedBox(height: 4,),
                Text(AppLocalizations.of(context)!.selectDate,
                    style: const TextStyle(color: Color(0xffb32f2f), fontSize: 18
                    )

                ),
              ],
            ),
          ),
              ),
            ]),
        ),
      ),
    );
  }

  var tabs = [ListTaps(), const SettingsTaps()];
  bool isVisible = false;
  DateTime? selectedDate;

  bool validForm() {
    if (keyform.currentState?.validate() == false || selectedDate == null) {
      return false;
    }
    if(widget.tskia!=null) {
      widget.tskia?.title = Title.text;
      widget.tskia?.description = Description.text;

      if (selectedDate != null) {
        widget.tskia!.time = Timestamp.fromDate(selectedDate!);
      }
    }
    return true;
  }

  void taskValidation(bool isAdd) async {
    if (!validForm()) {
      return;
    }

    task1 taskia1=task1(Title.text, Description.text, Timestamp.fromMillisecondsSinceEpoch(
            selectedDate!.millisecondsSinceEpoch),false);
      dialogUtilites.lodingDialog(context, "Please wait");
    tasksProvider provider1 = Provider.of(context,listen:false);
    provider obj = Provider.of<provider>(context,listen:false);
    isAdd==true?
   await provider1.addTask(taskia1,obj.user?.id):await provider1.editTask(widget.tskia,obj.user?.id);
    dialogUtilites.showmsg(context,widget.showmsg,
            postAction: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed(HomeScreen.routname);
        }
        );
       // Navigator.of(context).pop();

    }


  Future<void> showTaskDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days:365)),
        lastDate: DateTime.now().add(const Duration(days: 365))
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        isVisible = false;
      });
    }
  }

}
