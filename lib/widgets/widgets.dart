import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/model/wallpaperModel.dart';
import 'package:gallery/views/image_view.dart';

Widget wallpapersList({List<WallpaperModel> wallpaper, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpaper.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>ImageViewerPage(
                  imageUrl: wallpaper.src.portrait,
                )
              ));
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                  child: ClipRRect(
                      child: Image.network(
                        wallpaper.src.portrait,
                        fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
