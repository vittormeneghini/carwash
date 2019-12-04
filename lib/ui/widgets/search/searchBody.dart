import 'package:carwashapp/ui/widgets/searchWidget/cardSearch.dart';
import 'package:flutter/material.dart';
import '../../../core/models/serviceModel.dart';

class SearchBody extends StatelessWidget {
  List<Service> services;
  List<Expanded> cards = List<Expanded>();
  SearchBody(this.services) {
    cards = services
        .map((item) => Expanded(
              child: CardSearch(id: item.id, image: item.image, name: item.name, description: item.description),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Row> rows = List<Row>();
    Row aux;

    for (var i = 0; i < cards.length; i++) {
      if (aux != null && aux.children.length == 2) {
        rows.add(aux);
        aux = Row(children: [cards[i]]);
      } else if (aux != null && aux.children.length < 2) {
        aux.children.add(cards[i]);
        if(aux.children.length == 2)
        {
          rows.add(aux);
        }
      } else if (aux == null) {
        aux = Row(children: [cards[i]]);

        if(services.length == 1){
          rows.add(aux);
        }
      }
    }

    var listView = ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: rows.length,
      itemBuilder: (ctx, int index) {
        return rows[index];
      },
    );

    return Expanded(child: listView);
  }
}
