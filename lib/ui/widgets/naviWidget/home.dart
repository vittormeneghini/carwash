import 'package:carwashapp/ui/widgets/carousel/carouselPromotion.dart';
import 'package:carwashapp/ui/widgets/carousel/carouselServices.dart';
import 'package:carwashapp/ui/widgets/homeWidget/cardImageHome.dart';
import 'package:carwashapp/ui/widgets/homeWidget/loadCardsHome.dart';
import 'package:carwashapp/ui/widgets/homeWidget/loadCardsImageHome.dart';
import 'package:carwashapp/ui/widgets/naviWidget/homeCard.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        reverse: false,
        children: [
          LoadCardsImageHome(),
          Container(
            margin: EdgeInsets.all(20.0),
            child: CarouselPromotion(),
          ),
          HomeCard(
            carrousel: CarouselServices(),
            title: "Melhores serviços",
            onPressed: () {},
          ),
          LoadCardsHome()
        ],
      ),
    );
  }
}
