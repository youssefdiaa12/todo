import 'package:flutter/material.dart';
import 'package:todo/database/model/task_id.dart';
import 'package:todo/database/model/taskDao.dart';

class tasksProvider extends ChangeNotifier{




  Future<void>  addTask(  task1 ?taskia,String? id) async{
    await taskDao.createTask(taskia!, id);
notifyListeners();
return;
  }
  Future<void> deleteTask(  task1 ?taskia,String? id) async{
    await taskDao.deleteTask(taskia,id);
    notifyListeners();
    return;


  }
  Future<void>editTask( task1 ?taskia,String? id)async{
    await taskDao.editTask(taskia,id);
    notifyListeners();
    return;



  }







}