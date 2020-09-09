import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gallery/data/apikey.dart';
import 'package:gallery/model/wallpaperModel.dart';
import 'package:gallery/widgets/appBar.dart';
import 'package:gallery/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpaper = new List();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    getSearchedWallpaper(widget.searchQuery);
    // TODO: implement initState
    searchController.text = widget.searchQuery;
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
      appBar: AppBar(
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),

                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search Wallpaper',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: (){
                            getSearchedWallpaper(searchController.text);
                        },
                        child: Container(
                            child: Icon(Icons.search)))
                  ],
                ),
              ),
              wallpapersList(wallpaper: wallpaper, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
