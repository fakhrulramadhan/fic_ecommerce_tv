import 'package:flutter/material.dart';

class GlobalVariables {
  static const baseUrl = "http://localhost:1337/api";

  static const List<Map<String, String>> categoryImages = [
    {'title': 'Mobiles', 'image': 'assets/images/mobiles.jpeg'},
    {'title': 'Essentials', 'image': 'assets/images/essentials.jpeg'},
    {'title': 'Appliances', 'image': 'assets/images/appliances.jpeg'},
    {'title': 'Books', 'image': 'assets/images/books.jpeg'},
    {'title': 'Fashion', 'image': 'assets/images/fashion.jpeg'}
  ];

  static const List<String> bannerImages = [
    'https://storage.googleapis.com/astro-site/home/new-user.webp',
    'https://storage.googleapis.com/astro-site/home/24jam.webp',
  ];

  static const backgroundColor = Colors.white;
  static const Color greybackgroundColor = Color.fromARGB(255, 225, 219, 219);
  static var selectedNavBarColor = const Color(0xffEE4D2D);
  static const unselectedNavBarColor = Colors.black;
}
