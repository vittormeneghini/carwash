import 'package:carwashapp/core/models/categoryModel.dart';
import 'package:carwashapp/core/servicesModels/categoryService.dart';
import 'package:carwashapp/ui/widgets/homeWidget/cardHome.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';

class LoadCardsHome extends StatefulWidget {
  @override
  _LoadCardsHomeState createState() => _LoadCardsHomeState();
}

class _LoadCardsHomeState extends State<LoadCardsHome> {
  List<Category> categories;
  var categoryService = locator<CategoryService>();

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  Future<void> _getCategories() async {
    var _cateogires = await categoryService.fetchCategories();

    setState(() {
      categories = _cateogires;
    });
  }

  @override
  Widget build(BuildContext context) {
    return categories == null
        ? Center(child: CircularProgressIndicator())
        : categories.length == 0
            ? Container()
            : Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "De um upgrade em seu carro",
                      style: TextStyle(color: Colors.grey, fontSize: 15.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                      "O melhor do CarWash",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    )),
                    Container(
                        child: Column(
                      children: categories
                          .map((item) => CardHome(
                                categoryId: item.id,
                                image: item.image,
                                title: item.name,
                                description: item.description,
                              ))
                          .toList(),
                    ))
                  ],
                ));
  }
}
