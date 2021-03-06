import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/views/image_view.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoriesModel> categories =new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

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
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child:  Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child:  Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Wallpaper'
                        ),
                      ),
                    ),
                   GestureDetector(
                     onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Search(
                        searchQuery: searchController.text ,

                      )));
                     },
                     child:  Container(
                       child: Icon(Icons.search),
                     ),
                   )
                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              Container(
                height: 80.0,
                child:  ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index)
                  {
                    return CategoryCard(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl,

                    );
                  },
                ),
              ),

              wallpaperList(wallpapers: wallpapers , context: context)

            ],
          ),
        ),
      )

    );
  }
}

class CategoryCard extends StatelessWidget {
 final String imgUrl , title;
 CategoryCard({@required this.imgUrl ,@required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Categorie(
          categorieName: title.toLowerCase(),

        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4.0),
        child: Stack(
          children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imgUrl , height: 50.0, width: 100.0, fit: BoxFit.cover,),
              ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black26,
              ),
              height: 50.0,
              width: 100.0,
              alignment: Alignment.center,
              child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15.0),),
            )
          ],
        ),
      ),
    );
  }
}
