import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PatternCarousel extends StatelessWidget {
  final List<String> imgList;
  final double height;
  final double borderRadius;
  final double viewPortFraction;
  PatternCarousel(
      {this.imgList, this.height, this.borderRadius, this.viewPortFraction});

  @override
  Widget build(BuildContext context) {
    var body = imgList.length > 0
        ? Container(
            child: Column(
              children: [
                CarouselSlider(
                  height: height,
                  aspectRatio: 16 / 9,
                  viewportFraction: viewPortFraction,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  items: imgList.map((i) {                    
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                color: Colors.grey[200]),
                            child: Container(
                                width: 100.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage('$i')),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  color: Colors.redAccent,
                                )));
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : Container();
    return body;
  }
}
