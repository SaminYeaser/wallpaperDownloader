import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery/controller/apikey.dart';
import 'package:gallery/model/wallpaperModel.dart';
import 'package:gallery/widgets/appBar.dart';
import 'package:gallery/widgets/widgets.dart';
import 'package:http/http.dart' as http;
class Categories extends StatefulWidget {
  final String categoryName;
  Categories({this.categoryName});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<WallpaperModel> wallpaper = new List();
  @override
  void initState() {
    getSearchedWallpaper(widget.categoryName);
    super.initState();
  }

  getSearchedWallpaper(String query) async{
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=100", headers: {
      'Authorization': apiKey
    });
//    print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach((element){
//      print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);

      wallpaper.add(wallpaperModel);
    });
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff145C9E),
        title: AppName(),
        actions: <Widget>[
          Container(
            child: Icon(Icons.add),
            alignment: Alignment.centerRight,
            color: Colors.black26.withOpacity(0.0),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              wallpapersList(wallpaper: wallpaper, context: context)
            ],
          ),
        ),
      ),
    );
  }
}


