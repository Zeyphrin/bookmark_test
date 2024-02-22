import 'dart:typed_data';

class Favorite {
  int id;
  String title;
  String price;
  String image;

  Favorite({
    required this.title,
    required this.image,
    required this.price,
    required this.id
  });


  Favorite.fromMap({required map})
      : id = map['id'],
        title = map['title'],
        price = map['price'],
        image = map['image'];


  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'price' : price,
      'image': image
    };
  }
}