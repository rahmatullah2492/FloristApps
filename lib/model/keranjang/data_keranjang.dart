

class DataKeranjang {
  int? id;
  int? tanamanId; 
  String? imageTanaman;
  String? namaTanaman;
  int? quantity;
  int? userId;
  int? hargaTanaman;
  bool isChecked;
  

  DataKeranjang({
    this.id,
    this.tanamanId,
    this.imageTanaman,
    this.namaTanaman,
    this.quantity,
    this.userId,
    this.hargaTanaman,
    this.isChecked = false,
    
  });

  factory DataKeranjang.fromJson(Map<String, dynamic> json) {
    return DataKeranjang(
      id: json['id'],
      tanamanId: json['tanaman_id'], 
      imageTanaman: json['image_tanaman'],
      namaTanaman: json['nama_tanaman'],
      quantity: json['quantity'],
      userId: json['user_id'],
      hargaTanaman: json['harga_tanaman'],
      
      isChecked: false,
    );
  }

  // Metode toJson untuk mengonversi objek DataKeranjang menjadi representasi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_tanaman': imageTanaman,
      'nama_tanaman': namaTanaman,
      'quantity': quantity,
      'user_id': userId,
      'harga_tanaman': hargaTanaman,
      'tanaman_id': tanamanId, // Tambahkan tanamanId ke hasil konversi JSON
      // Properti lain...
    };
  }

   
}

























// class DataKeranjang {
//   int? id;
//   String? imageTanaman;
//   String? namaTanaman;
//   int? quantity;
//   int? userId;
//   int? hargaTanaman;
//   int? tanamanId; // Tambahkan properti tanamanId
//   bool isChecked;

//   DataKeranjang({
//     this.id,
//     this.imageTanaman,
//     this.namaTanaman,
//     this.quantity,
//     this.userId,
//     this.hargaTanaman,
//     this.tanamanId, // Tambahkan tanamanId ke konstruktor
//     this.isChecked = false,
//   });

//   factory DataKeranjang.fromJson(Map<String, dynamic> json) {
//     return DataKeranjang(
//       id: json['id'],
//       imageTanaman: json['image_tanaman'],
//       namaTanaman: json['nama_tanaman'],
//       quantity: json['quantity'],
//       userId: json['user_id'],
//       hargaTanaman: json['harga_tanaman'],
//       tanamanId: json['tanaman_id'] ?? 0,// Tambahkan penanganan tanamanId
//     );
//   }

  // Metode toJson untuk mengonversi objek DataKeranjang menjadi representasi JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'image_tanaman': imageTanaman,
  //     'nama_tanaman': namaTanaman,
  //     'quantity': quantity,
  //     'user_id': userId,
  //     'harga_tanaman': hargaTanaman,
  //     'tanaman_id': tanamanId, // Tambahkan tanamanId ke hasil konversi JSON
  //     // Properti lain...
  //   };
  // }
//}







// class DataKeranjang {
//   int? id;
//   String? imageTanaman;
//   String? namaTanaman;
//   int? quantity;
//   int? userId;
//   int? hargaTanaman;
//   bool isChecked;
//   //int? totalHarga;

//   DataKeranjang({
//     this.id,
//     this.imageTanaman,
//     this.namaTanaman,
//     this.quantity,
//     this.userId,
//     this.hargaTanaman,
//     this.isChecked = false,
//     //this.totalHarga
//   });

//   factory DataKeranjang.fromJson(Map<String, dynamic> json) {
//     return DataKeranjang(
//       id: json['id'],
//       imageTanaman: json['image_tanaman'],
//       namaTanaman: json['nama_tanaman'],
//       quantity: json['quantity'],
//       userId: json['user_id'],
//       hargaTanaman: json['harga_tanaman'],
//       // totalHarga: json['total_harga'],
//     );
//   }

//   get tanamanId {
//     return id;
//   }

// // BARU
//   // Metode toJson untuk mengonversi objek DataKeranjang menjadi representasi JSON
//   Map<String, dynamic> maps() {
//     return {
//       'id': id,
//       'image_tanaman': imageTanaman,
//       'nama_tanaman': namaTanaman,
//       'quantity': quantity,
//       'user_id': userId,
//       'harga_tanaman': hargaTanaman,
//       // Properti lain...
//     };
//   }

//   toMap() {}
// }