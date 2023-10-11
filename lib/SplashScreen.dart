import 'package:flutter/material.dart';
import 'package:todo/ui/Common/Provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var obj=provider();
    return FutureBuilder(
      future: obj.loadTheme(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while waiting
        } else {
          String ?theme =obj.getTheme();
          return Scaffold(
            body: Image(
              image: theme == 'Light' ? AssetImage('assets/images/splash@3x.png') : AssetImage('assets/images/darkSplash.png'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        }
      },
    );
  }


}
