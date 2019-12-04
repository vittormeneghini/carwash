class Service{
  String id;
  String name;
  String image;
  String categoryId;
  String description;
  double price;


  Service({this.name, this.image, this.categoryId, this.price, this.description});

  Service.fromMap(Map snapShot, String id):
    id = id ?? '',
    name = snapShot['name'] ?? '',
    image = snapShot['image'] ?? '',
    categoryId = snapShot['category_id'] ?? '',
    description = snapShot['description'] ?? '',
    price = snapShot['price'] ?? 0;


  toJson(){
    return{
      "name": name,
      "description": description,
      "image": image,
      "category_id": categoryId,
      "price": price
    };
  }
}