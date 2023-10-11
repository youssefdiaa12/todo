import 'package:cloud_firestore/cloud_firestore.dart';

class task1 {
  String? title;
  String? description;
  String? id;
  Timestamp? time;
  bool isDone;

  task1(
    this.title,
    this.description,
    this.time,
    this.isDone, {
    this.id,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time,
      'isDone': isDone
    };
  }

  task1.fromFireStore(Map<String, dynamic>? mp)
      : this(mp?['title'], mp?['description'], mp?['time'], mp?['isDone'],
            id: mp?['id']);
}
