class Address
{
  String id;
  String zipCode;
  String street;
  String neighborhood;
  String city;
  int number;
  String country;
  bool selected;

  
  Address({this.zipCode, this.street, this.number, this.neighborhood, this.city, this.country, this.selected});

  Address.fromMap(Map snapShot, String id):
    id = id ?? '',
    zipCode = snapShot['zip_code'] ?? '',
    street = snapShot['street'] ?? '',
    number = snapShot['number'] ?? '',
    neighborhood = snapShot['neighborhood'] ?? '',
    city = snapShot['city'] ?? '',
    country = snapShot['country'] ?? '',
    selected = snapShot['selected'] ?? '';

  toJson(){
    return{
      "zip_code": zipCode,
      "street": street,
      "number": number,
      "neighborhood": neighborhood,
      "city": city,
      "country": country,
      "selected": selected
    };
  }
}