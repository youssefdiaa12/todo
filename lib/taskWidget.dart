import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/HomeScreen.dart';
import 'package:todo/database/model/task_id.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/Common/dialogUtilites.dart';
import 'package:todo/ui/Common/tasksProvider.dart';
import 'package:todo/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class taskWidget extends StatefulWidget {
  task1? t;

  taskWidget(this.t, {super.key});

  @override
  State<taskWidget> createState() => _taskWidgetState();
}

class _taskWidgetState extends State<taskWidget> {

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    tasksProvider provider1 = Provider.of<tasksProvider>(context);


    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 6.0),
      child: Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              setState(() {
                deleteFunc();
              });
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
            padding: const EdgeInsets.all(12),
          ),
          SlidableAction(
            onPressed: (context) {
              setState(()  {
                showAddTask();
              });
            },
            backgroundColor: Colors.grey,
            icon: Icons.edit_note,
            label: AppLocalizations.of(context)!.edit,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),



        ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: obj.currenttheme==ThemeMode.light?Color(0xff4D3D3DFF):Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Container(
                      width: 4,
                      height: 62,
                      color: widget.t!.isDone?  Colors.green : Theme.of(context).primaryColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.t?.title}',
                            style: TextStyle(
                                color: widget.t!.isDone? Colors.green : Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,fontSize: 20)),
                        Text(
                          '${widget.t?.description}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.t!.isDone?      Padding(
                 padding: EdgeInsets.only(top:9.0,right:16,bottom:6),
                 child: Text(AppLocalizations.of(context)!.done,style: TextStyle(color:Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
               ): Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child:
                  InkWell(
                    onTap: ()async{
                      setState(() {
                        widget.t?.isDone=true;
                      });
                      provider1.editTask(widget.t, obj.user?.id);
                      },
                    child:
                    Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).primaryColor,
                      ),
                      child:const Icon(Icons.check_outlined,
                          color: Colors.white, size: 30),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void deleteFunc() async {
    dialogUtilites.showmsg(context, 'are you sure you want to delete?',
        pos: 'Yes', txt: 'Cancel', postAction: () {
      deletfromFireStore();
    });
  }

  void deletfromFireStore() async {
    Navigator.pop(context);
    provider obj = Provider.of<provider>(context, listen: false);
    tasksProvider provider1 = Provider.of(context, listen: false);
  await  provider1.deleteTask(widget.t, obj.user?.id);
    Navigator.pushReplacementNamed(context, HomeScreen.routname);
  }


  Future<void> showAddTask() async{
   await  showModalBottomSheet(
        context: context,
        builder: (builder) {
          return task(AppLocalizations.of(context)!.editTask,'Task edited successfully',tskia: widget.t,is_add: false,);
        });
  }



}
