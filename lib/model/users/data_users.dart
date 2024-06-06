

class DataUser {
  int? id;
  String? name;
  // dynamic image;
  String? image;
  String? email;
  String? token;
 

  DataUser({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token,

  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      email: json['email'],
      token: json['token'],
    );
  }
}