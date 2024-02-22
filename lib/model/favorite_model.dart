class Favorite {
  int id;
  String title;
  String image;
  String price;

  Favorite({required this.id, required this.title, required this.image, required this.price});

  Favorite.fromMap({required map})
      : id = map["id"],
        title = map["title"] ?? "",
        image = map["image"] ?? "",
        price = map["image"] ?? "";

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "image": image, "price": price};
  }
}