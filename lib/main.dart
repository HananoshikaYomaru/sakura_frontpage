import 'package:flutter/material.dart';
import 'package:sakura/screens/welcome_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const Color kBaseColor = Color(0xFFFFE7E7);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Flutter Demo',
      theme: NeumorphicThemeData(
        baseColor: kBaseColor , 
        lightSource: LightSource.topLeft , 
        depth : 8, 
      ),
      initialRoute: WelcomeScreen.path,
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.path : (context) => WelcomeScreen() ,
      } , 
    );
  }
}
