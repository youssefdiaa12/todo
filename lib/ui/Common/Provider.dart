import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/model/user.dart' as myuser;
import 'package:todo/database/model/userDao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class provider extends ChangeNotifier {
  bool is_visible=true ;
  User? firebaseauth;
  myuser.User? user;
  bool get isVisible => is_visible;
  int selectedindex=0;
  bool is_deleted=false;
  bool is_done=false;
  DateTime selecteddate= DateTime.now();
  ThemeMode currenttheme = ThemeMode.dark;
  SharedPreferences? preferences;
  String lang = 'English';
  void changeVisability() {
    notifyListeners();
  }

  bool Loggedin() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> logout() async {
    user=null;
    await FirebaseAuth.instance.signOut();
  }


void ChangeDate(DateTime obj){
    selecteddate=obj;
    notifyListeners();


}

 Future<myuser.User?> retrivedata() async {
    firebaseauth = FirebaseAuth.instance.currentUser;
    user = await userDao.getuser(firebaseauth!.uid);
    return user;
  }

  Future<void>login(String email , String password)async{
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
     user = await userDao.getuser(credential.user?.uid);
  }
  Future<void>register(String email , String password,String firstName)async{
    final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    await userDao.createuser(myuser.User(firstName,email,result.user?.uid,));

  }

  void changetheme(ThemeMode theme) {
    if (currenttheme == theme) {
      SaveTheme(currenttheme);
      return;
    } else {
      currenttheme = theme;
      SaveTheme(currenttheme);
      notifyListeners();
    }
  }

  void changeLanguage(String lan) {
    if (lang == lan) {
      saveLanguage(lang);
      return;
    } else {
      lang = lan;
      saveLanguage(lang);
      notifyListeners();
    }
  }

  Future<void> SaveTheme(ThemeMode t) async {
    String theme1 = t == ThemeMode.dark ? 'Dark' : 'Light';
    await preferences?.setString('theme', theme1);
  }

  String? getTheme() {
    return preferences?.getString('theme');
  }

  Future<void> loadTheme() async {
    preferences = await SharedPreferences.getInstance();

    String? theme = getTheme();
    if (theme != null) {
      theme == 'Dark'
          ? currenttheme = ThemeMode.dark
          : currenttheme = ThemeMode.light;
    }
  }

  Future<void> saveLanguage(String lang) async {
    await preferences?.setString('lang', lang);
  }

  String? getLanguage() {
    return preferences?.getString('lang');
  }

  Future<void> loadLang() async {
    preferences = await SharedPreferences.getInstance();
    String? lang1 = getLanguage();

    if (lang1 != null) {
      lang1 == 'English' ? lang = 'English' : lang = 'العربيه';
    }
  }
}