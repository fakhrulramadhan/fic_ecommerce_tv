import 'package:carousel_slider/carousel_slider.dart';
import 'package:fic_ecommerce_tv/common/global_variable.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.bannerImages.map((e) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              e,
              height: 200.0,
              fit: BoxFit.contain,
            ),
          );
        }).toList(),
        options:
            CarouselOptions(viewportFraction: 1, height: 200, autoPlay: true));
  }
}
