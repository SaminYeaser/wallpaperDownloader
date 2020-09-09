import 'dart:convert';
import 'package:gallery/views/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery/controller/data.dart';
import 'package:gallery/model/category_model.dart';
import 'package:gallery/model/wallpaperModel.dart';
import 'package:gallery/views/image_view.dart';
import 'package:gallery/views/search.dart';
import 'package:gallery/widgets/appBar.dart';
import 'package:gallery/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:gallery/controller/apikey.dart';


class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List();
  List<WallpaperModel> wallpaper = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallpaper() async{
    var response = await http.get("https://api.pexels.com/v1/curated?per_page=100", headers: {
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
  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff145C9E),
        title: AppName(),
      ),
      body: SingleChildScrollView(

        physics: ClampingScrollPhysics(),
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
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context)=>Search(
                        searchQuery: searchController.text,
                         )
                       ));
                     },
                       child: Container(
                           child: Icon(Icons.search)))
                  ],
                ),
              ),
//            SizedBox(
//              height: 2,
//            ),
              Container(
                height: 60,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                  return CategoriTile(
                        title: categories[index].categoryName,
                        imgURL: categories[index].imgURL,
                  );
                    }
                ),
              ),
              SizedBox(
                height: 8,
              ),
              wallpapersList(wallpaper: wallpaper, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
class CategoriTile extends StatelessWidget {
  final String imgURL;
  final String title;

  const CategoriTile({Key key, @required this.imgURL,@required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> Categories(
           categoryName: title.toLowerCase()
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                child: Image.network(
                  imgURL,
                  height: 60,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              borderRadius: BorderRadius.circular(16),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black26,
              ),

              height: 60, width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
