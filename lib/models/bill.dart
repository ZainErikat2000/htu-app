class Bill {
  Bill({required this.date, required this.items});

  String date;
  List<dynamic> items;

  factory Bill.fromJson(Map<String, dynamic> json) =>
      Bill(date: json['date'], items: json['items']);
}
