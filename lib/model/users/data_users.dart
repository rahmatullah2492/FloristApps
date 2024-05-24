
class DataUser {
  int? id;
  String? name;
  dynamic image;
  String? email;
  String? token;


  DataUser({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token,
    
  });

  factory DataUser.fromJson(Map<String, dynamic> json){
    return DataUser(
      id: json['user']['id'],
      name: json['user']['name'],
      image: json['user']['image'],
      email: json['user']['email'],
      token: json['user']['token'],
    );

  } 
}
