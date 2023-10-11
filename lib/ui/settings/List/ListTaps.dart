import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/database/model/taskDao.dart';
import 'package:todo/taskWidget.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/login/Login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListTaps extends StatefulWidget {
  static const String routname = 'ListTap';

  @override
  State<ListTaps> createState() => _ListTapsState();
}

class _ListTapsState extends State<ListTaps> {


  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    DateTime _selectedDay=obj.selecteddate,_focusedDay=DateTime.now();
    return Scaffold(
      backgroundColor: obj.currenttheme==ThemeMode.light?Colors.white:Colors.black12,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top:24,left:10),
            child: IconButton(
                onPressed: () async {
                  await obj.logout();
                  Navigator.pushReplacementNamed(context, LoginScreen.routname);
                },
                icon: const Icon(Icons.logout),
                color:obj.currenttheme==ThemeMode.light?Colors.white:Colors.black),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top:33,left:8),
            child: Text('To do list',style: Theme.of(context).textTheme.headlineSmall,textAlign: TextAlign.start,),
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                obj.ChangeDate(_focusedDay);
              });
            },
            calendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
              //make padding between date number and date name like sat , sun so it can clear appearance
              cellAlignment:AlignmentDirectional.center,
              outsideDaysVisible: false,

            ),
            focusedDay: obj.selecteddate,
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
          ),
          Container(
              height:50),
          Expanded(
            child:
            StreamBuilder(
              stream: taskDao.listForTasks(obj.user?.id ?? '', _selectedDay),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          HomeScreen.routname,
                        );
                      },
                      child:  Text(snapshot.error?.toString()??"",),
                    ),
                  );
                } else {
                  var taskList = snapshot.data;
                  if (taskList == null || taskList.isEmpty) {
                    return  Center(
                      child: Text(
                        'No tasks found',
                        style: TextStyle(color:obj.currenttheme==ThemeMode.light?Colors.black:Colors.white, fontSize: 20),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Center(child: taskWidget(taskList[index]));
                      },
                      itemCount: taskList.length,
                    );
                  }
                }
              },
            ),

          ),
        ],
      ),
    );
  }
}