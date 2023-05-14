class User {
  User(
      {required this.fName,
      required this.lName,
      required this.dob,
        required this.email,
      required this.pic});

  String fName;
  String lName;
  String dob;
  String email;
  String pic;

  factory User.fromJson(Map<String, dynamic> json) => User(
      fName: json['fname'],
      lName: json['lname'],
      dob: json['dob'],
      email: json['email'],
      pic: json['pic']);
}
