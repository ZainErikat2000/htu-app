class Item {
  Item(
      {required this.name,
      required this.price,
      required this.category,
      required this.date,
      required this.pic});

  String name;
  num price;
  String category;
  String date;
  String pic;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      name: json['name'],
      price: json['price'] as double,
      category: json['category'],
      date: json['date'],
      pic: json['pic']);
}
