import 'package:carwashapp/core/models/addressModel.dart';
import 'package:carwashapp/core/models/personModel.dart';
import 'package:carwashapp/core/servicesModels/addressService.dart';
import 'package:carwashapp/locator.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';

class DefaultBar extends StatefulWidget {
  Person loggedPerson;
  DefaultBar({this.loggedPerson});

  @override
  _DefaultBarState createState() =>
      _DefaultBarState(loggedPerson: loggedPerson);
}

class _DefaultBarState extends State<DefaultBar> {
  Person loggedPerson;
  List<Address> address;
  Address selectedAddress;
  String strSelected;
  _DefaultBarState({this.loggedPerson});
  var addressService = locator<AddressService>();

  @override
  void initState() {
    getAddresses();
    super.initState();
  }

  Future<void> getAddresses() async {
    var _addresses = await addressService.fetchAddresses(loggedPerson.id);
    if (_addresses.length > 0) {
      var _selected = _addresses.firstWhere((item) {
        return item.selected;
      });
      setState(() {
        selectedAddress = _selected;
        strSelected =
            (selectedAddress.street + ", " + selectedAddress.number.toString())
                .toString();
      });
    } else {
      setState(() {
        strSelected = "Selecione um endereço";
      });
    }

    setState(() {
      address = _addresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      height: 85.0,
      color: Colors.blue,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.person_pin,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              child: strSelected == null
                  ? CircularProgressIndicator()
                  : FindDropdown(
                      items: address != null && address.length > 0
                          ? address.map((item) {
                              return item.street +
                                  ", " +
                                  item.number.toString();
                            }).toList()
                          : ['Selecione um endereço'],
                      onChanged: (String text) async {
                        if (loggedPerson != null) {
                          var _addressSelected = address.firstWhere((item) {
                            return item.street +
                                    ", " +
                                    item.number.toString() ==
                                text;
                          });

                          var _selected = address.firstWhere((item) {
                            return item.selected;
                          });

                          if (_selected != null) {
                            await addressService.updateAddress(
                                loggedPerson.id, _selected, _selected.id);
                          }

                          _addressSelected.selected = true;

                          await addressService.updateAddress(loggedPerson.id,
                              _addressSelected, _addressSelected.id);

                          setState(() {
                            selectedAddress = _addressSelected;
                          });
                        }
                      },
                      selectedItem: strSelected,
                    ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
