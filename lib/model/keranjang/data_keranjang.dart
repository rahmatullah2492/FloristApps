class DataKeranjang {
  int? id;
  String? imageTanaman;
  String? namaTanaman;
  int? quantity;
  int? userId;
  int? hargaTanaman;
  bool isChecked;
  //int? totalHarga;

  DataKeranjang({
    this.id,
    this.imageTanaman,
    this.namaTanaman,
    this.quantity,
    this.userId,
    this.hargaTanaman,
    this.isChecked = false,
    //this.totalHarga
  });

  factory DataKeranjang.fromJson(Map<String, dynamic> json) {
    return DataKeranjang(
      id: json['id'],
      imageTanaman: json['image_tanaman'],
      namaTanaman: json['nama_tanaman'],
      quantity: json['quantity'],
      userId: json['user_id'],
      hargaTanaman: json['harga_tanaman'],
      // totalHarga: json['total_harga'],
    );
  }
}

// class Keranjang {
//   String? imageTanaman;
//   String? namaTanaman;
//   int? quantity;
//   int? hargaTanaman;
//   int? totalHarga;

//   Keranjang({
//     this.imageTanaman,
//     this.namaTanaman,
//     this.quantity,
//     this.hargaTanaman,
//     this.totalHarga,
//   });

//   factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
//         imageTanaman: json['image_tanaman'] as String?,
//         namaTanaman: json['nama_tanaman'] as String?,
//         quantity: json['quantity'] as int?,
//         hargaTanaman: json['harga_tanaman'] as int?,
//         totalHarga: json['total_harga'] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         'image_tanaman': imageTanaman,
//         'nama_tanaman': namaTanaman,
//         'quantity': quantity,
//         'harga_tanaman': hargaTanaman,
//         'total_harga': totalHarga,
//       };
// }
