import 'package:carwashapp/core/servicesModels/serviceService.dart';
import 'package:carwashapp/locator.dart';
import 'package:carwashapp/ui/widgets/carousel/patternCarousel.dart';
import 'package:flutter/material.dart';


class CarouselServices extends StatefulWidget {

  @override
  _CarouselServicesState createState() => _CarouselServicesState();
}

class _CarouselServicesState extends State<CarouselServices> {
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
            height: 150.0,
            borderRadius: 20,
            viewPortFraction: 0.6,
          );
  }
}