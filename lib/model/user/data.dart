// import 'dart:convert';

// class Data {
//   int? idUser;
//   String? namaLengkap;
//   String? fotoProfil;
//   String? jenisKelamin;
//   String? tanggalLahir;
//   String? username;
//   String? password;
//   String? email;
//   String? alamatRumah;
//   String? noTelp;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Data({
//     this.idUser,
//     this.namaLengkap,
//     this.fotoProfil,
//     this.jenisKelamin,
//     this.tanggalLahir,
//     this.username,
//     this.password,
//     this.email,
//     this.alamatRumah,
//     this.noTelp,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Data.fromMap(Map<String, dynamic> data) => Data(
//         idUser: data['id_user'] as int?,
//         namaLengkap: data['nama_lengkap'] as String?,
//         fotoProfil: data['foto_profil'] as String?,
//         jenisKelamin: data['jenis_kelamin'] as String?,
//         tanggalLahir: data['tanggal_lahir'] as String?,
//         username: data['username'] as String?,
//         password: data['password'] as String?,
//         email: data['email'] as String?,
//         alamatRumah: data['alamat_rumah'] as String?,
//         noTelp: data['no_telp'] as String?,
//         createdAt: data['created_at'] == null
//             ? null
//             : DateTime.parse(data['created_at'] as String),
//         updatedAt: data['updated_at'] == null
//             ? null
//             : DateTime.parse(data['updated_at'] as String),
//       );

//   Map<String, dynamic> toMap() => {
//         'id_user': idUser,
//         'nama_lengkap': namaLengkap,
//         'foto_profil': fotoProfil,
//         'jenis_kelamin': jenisKelamin,
//         'tanggal_lahir': tanggalLahir,
//         'username': username,
//         'password': password,
//         'email': email,
//         'alamat_rumah': alamatRumah,
//         'no_telp': noTelp,
//         'created_at': createdAt?.toIso8601String(),
//         'updated_at': updatedAt?.toIso8601String(),
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [Data].
//   factory Data.fromJson(String data) {
//     return Data.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [Data] to a JSON string.
//   String toJson() => json.encode(toMap());
// }
