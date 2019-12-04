class Category{
  String id;
  String name;
  String description;
  String image;
  bool main;


  Category({this.name, this.image});

  Category.fromMap(Map snapshot, String id):
    id = id ?? '',
    name = snapshot['name'] ?? '',    
    description = snapshot['description'] ?? '',
    main = snapshot['main'] ?? false,
    image = snapshot['image'] ?? '';

  toJson(){
    return{
      "name": name,
      "description": description,
      "main": main,
      "image": image
    };
  }
}