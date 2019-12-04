import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/ui/widgets/carousel/patternCarousel.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

class CarouselCategories extends StatefulWidget {
  @override
  _CarouselCategoriesState createState() =>
      _CarouselCategoriesState();
}

class _CarouselCategoriesState extends State<CarouselCategories> {
  List<String> imgCategories = List<String>();
  var categoryService = locator<CategoryService>();

  @override
  void initState() {
    super.initState();
    _getCategoriesCarousel();
  }

  Future<void> _getCategoriesCarousel() async {
    var categories = await categoryService.fetchCategories();
    List<String> imgsAux = List<String>();
    for (var item in categories) {
      imgsAux.add(item.image);
    }

    setState(() {
      imgCategories = imgsAux;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool loadingFields() => imgCategories == null;

    return loadingFields()
        ? Center(child: CircularProgressIndicator())
        : PatternCarousel(
            imgList: imgCategories,
            height: 75.0,
            borderRadius: 5,
            viewPortFraction: 0.3,
          );
  }
}
