import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/SplashScreen.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/ui/Common/Provider.dart';
import 'package:todo/ui/Common/tasksProvider.dart';
import 'package:todo/ui/Common/themeData.dart';
import 'package:todo/ui/register/Register.dart';
import 'package:todo/ui/login/Login.dart';
import 'package:todo/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/settings/List/ListTaps.dart';
import 'package:todo/ui/settings/SettingsTaps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const MaterialApp(
    home: SplashScreen(),
  )
  );
  Timer(const Duration(seconds: 2), ()
  async{
    var provider1 =provider();
    await provider1.retrivedata();
    await provider1.loadLang();
    runApp(
        MultiProvider(
          providers: [
             ChangeNotifierProvider(
              create:(buildContext) =>tasksProvider()) ,
               ChangeNotifierProvider(
                  create: (buildContext) => provider1),
          ],
          child:const MyApp(),

        ));
  }
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    provider obj = Provider.of<provider>(context);
    obj.Loggedin() == true?obj.retrivedata():null;
    return MaterialApp(
      title: 'Flutter Demo',
      theme:MyThemeData.lightTheme,
      darkTheme: MyThemeData.DarkTheme,
      themeMode: obj.currenttheme,
      routes: {
        RegisterScreen.routname: (_) => RegisterScreen(),
        LoginScreen.routname: (_) => LoginScreen(),
        HomeScreen.routname: (_) => HomeScreen(),
        ListTaps.routname: (_) => ListTaps(),
        SettingsTaps.routname: (_) => SettingsTaps(),

      },
     initialRoute: obj.Loggedin()==true?HomeScreen.routname:
     LoginScreen.routname,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ar', ''), // Arabic
      ],
      locale: obj.lang == 'English'
          ? const Locale('en', '')
          : const Locale('ar', ''),


    );
  }
}
//AppLocalizations.of(context)!.aya_elkorst,

