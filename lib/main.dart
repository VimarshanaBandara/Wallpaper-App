import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/home.dart';
void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: HomePage(),
    );
  }
}
