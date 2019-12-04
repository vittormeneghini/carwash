import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/carousel/patternCarousel.dart';
import 'package:flutter/material.dart';


class CarouselPromotion extends StatefulWidget {

  @override
  _CarouselPromotionState createState() => _CarouselPromotionState();
}

class _CarouselPromotionState extends State<CarouselPromotion> {
  List<String> imgService = List<String>();
  var serviceService = locator<ServiceService>();

  @override
  void initState() {
    super.initState();
    _getServiceCarousel();
  }

  Future<void> _getServiceCarousel() async {
    var services = await serviceService.fetchServices();
    List<String> imgsAux = List<String>();
    for (var item in services) {
      imgsAux.add(item.image);
    }

    setState(() {
      imgService = imgsAux;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool loadingFields() => imgService == null;

    return loadingFields()
        ? Center(child: CircularProgressIndicator())
        : PatternCarousel(
            imgList: imgService,
            height: 230.0,
            borderRadius: 20,
            viewPortFraction: 1.0,
          );
  }
}