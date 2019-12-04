import 'package:carwashapp/core/servicesModels/favoriteService.dart';
import 'package:carwashapp/ui/widgets/favorite/listenFavoritesCollaborator.dart';
import 'package:carwashapp/ui/widgets/favorite/listenFavoritesServices.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite>
    with SingleTickerProviderStateMixin {
  var favoriteService = locator<FavoriteService>();

  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    var expanded = Expanded(
      child: Column(
        children: [
          Container(
            height: 80.0,
            child: Material(
              color: Colors.blue,
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      indexSelected = index;
                    });
                  },
                  labelColor: Colors.white,
                  indicatorColor: Colors.blueGrey,
                  unselectedLabelColor: Colors.white54,
                  tabs: [
                    Icon(
                      Icons.person,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.local_car_wash,
                      size: 40.0,
                    )
                  ],
                ),
              ),
            ),
          ),
          indexSelected == 0 ? ListenFavoritesServices() : ListenFavoritesCollaborator()
        ],
      ),
    );

    return expanded;
  }
}
