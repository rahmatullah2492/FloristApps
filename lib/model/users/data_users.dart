class DataUser {
  int? id;
  String? name;
  String? image;
  String? email;
  String? alamatRumah;
  String? noTelp;
  String? tanggalLahir;
  String? jenisKelamin;
  String? token;

  DataUser({
    this.id,
    this.name,
    this.image,
    this.email,
    this.alamatRumah,
    this.noTelp,
    this.tanggalLahir,
    this.jenisKelamin,
    this.token,
    DataUser? data,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
      alamatRumah: json['alamat_rumah'] ?? '',
      noTelp: json['no_telp'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      token: json['token'],
    );
  }

  get userId {
    return id;
  }
}
