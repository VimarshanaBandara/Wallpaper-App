import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

class Categorie extends StatefulWidget {
  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();
  getTrendingWallpapers()async
  {
    var response =await http.get("https://api.pexels.com/v1/curated",
        headers: {
          "Authorization" : apiKey});

    // print(response.body.toString());
    Map<String , dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel =WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);

    });


    setState(() {

    });


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
