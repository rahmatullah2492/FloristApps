// import 'package:Florist/model/pesanan/pesanan.dart';
// import 'package:Florist/model/users/data_users.dart';

// class PostData {
//   int? id;
//   DataUser? user;
//   DataPesanan? pesanan;
//   String? message;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;

//   PostData({
//     this.id,
//     this.user,
//     this.pesanan,
//     this.message,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory PostData.fromJson(Map<String, dynamic> json) {
//     return PostData(
//       id: json['id'],
//       pesanan: DataPesanan(
//         userId: json['pesanan']['user_id'],
//         buktiBayar: json['pesanan']['bukti_bayar'],
//         ),

//       user: DataUser(
//         id: json['user']['id'],
//         name: json['user']['name'],
//         image: json['user']['image'],
//         )
//     );
//   }
// }
