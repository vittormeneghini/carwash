import 'package:carwashapp/core/models/categoryModel.dart';
import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/ui/widgets/homeWidget/cardImageHome.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';

class LoadCardsImageHome extends StatefulWidget {
  @override
  _LoadCardsImageHomeState createState() => _LoadCardsImageHomeState();
}

class _LoadCardsImageHomeState extends State<LoadCardsImageHome> {
  var categoryService = locator<CategoryService>();

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  List<Category> mainCategories;
  Future<void> getCategories() async {
    var _mainCategories = await categoryService.fetchMainCategories();
    setState(() {
      mainCategories = _mainCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return mainCategories == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : mainCategories.length == 0
            ? Container()
            : Container(
                child: Row(
                    children:
                        mainCategories.map((item) => CardImageHome()).toList()),
                padding: EdgeInsets.all(10.0),
              );
  }
}
