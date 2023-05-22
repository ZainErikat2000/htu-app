class Item {
  Item(
      {required this.name,
      required this.price,
      required this.category,
      required this.date,
      required this.pic,
      required this.id});

  String name;
  num price;
  String category;
  String date;
  String pic;
  String id;

  factory Item.fromJson(Map<String, dynamic> json, String id) => Item(
      name: json['name'],
      price: json['price'] as double,
      category: json['category'],
      date: json['date'],
      pic: json['pic'],
      id: id);
}
