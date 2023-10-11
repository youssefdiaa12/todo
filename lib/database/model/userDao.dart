import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/user.dart';

class userDao {

 static CollectionReference<User> getusercollection(){
  var db = FirebaseFirestore.instance;
  var dbDoc = db.collection('user').withConverter<User>(
   fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()!),
   toFirestore: (value, options) => value.toFireStore(),
  );
 return dbDoc;
 }

 static Future<void> createuser(User user) {
  var dbDoc=getusercollection();
 return dbDoc.doc(user.id).set(user);

 }

 static Future<User?> getuser( String ?id)async{
  var doc1=getusercollection();
  var docSnapShot =await  doc1.doc(id).get();
return docSnapShot.data();

 }

}