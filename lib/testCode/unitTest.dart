import 'package:gallery/model/wallpaperModel.dart';
import 'package:gallery/views/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

void main(){
  test('Check the list is empty', (){
  Categories categoriList = Categories();
  expect(categoriList.categoryName, <WallpaperModel>[]);
  });

  test('One should be one', (){
    int expectedNumber = 1;

    expect(expectedNumber,1);
  });

}