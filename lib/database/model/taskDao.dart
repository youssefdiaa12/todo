import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/task_id.dart';
import 'package:todo/database/model/userDao.dart';

class taskDao {
  static CollectionReference<task1> gettaskcollection(String id) {
    var db = userDao
        .getusercollection()
        .doc(id)
        .collection('tasks')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                task1.fromFireStore(snapshot.data()!),
            toFirestore: (value, options) => value.toFireStore());

    return db;
  }

  static Future<void> createTask(task1 taskia, String? id) async {
    var dbRef = gettaskcollection(id!).doc();
    taskia.id = dbRef.id;

    await dbRef.set(taskia);
  }

  static Future<List<task1>> getTasks(String id) async {
    var dbRef = await gettaskcollection(id).get();
    var taskList = dbRef.docs.map((snapshot) => snapshot.data()).toList();
    return taskList;
  }

  static Future<void> deleteTask(task1? taskia, String? id) async {
    await gettaskcollection(id!).doc(taskia?.id).delete();
  }

  static Future<void> editTask(task1? taskia, String? id) async {
    await gettaskcollection(id!).doc(taskia?.id).update({
      'title': taskia?.title,
      'description': taskia?.description,
      'time': taskia?.time,
      'isDone': taskia?.isDone

    });
  }

  static Stream<List<task1>> listForTasks(String id, DateTime obj) async* {

    var start = DateTime(obj.year, obj.month, obj.day);
    var end = DateTime(obj.year, obj.month, obj.day, 23, 59, 59);

    var data = gettaskcollection(id)
        .where('time', isGreaterThanOrEqualTo: start)
        .where('time', isLessThanOrEqualTo: end)
        .snapshots();

    yield* data.map((snapshot) =>
        snapshot.docs.map((snapshot) => snapshot.data()).toList());
  }
}
