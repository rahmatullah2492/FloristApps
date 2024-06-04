// import 'package:Florist/model/keranjang/api_response.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/list_tumbuhan.dart';
// import '../views/pages.dart';

// late Future<ApiResponseKeranjang> _futureKeranjang;

// class KeranjangWidget extends StatelessWidget {
//   const KeranjangWidget({
//     Key? key,
//     required this.index,
//     required this.plantList,
//   }) : super(key: key);

//   final int index;
//   final List<Plant> plantList;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(
//           () => DetailPage(
//             plantId: plantList[index].plantId,
//           ),
//           transition:
//               Transition.downToUp, // Animasi transisi dari bawah ke atas
//           duration: Duration(milliseconds: 450),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white, // Warna cokelat pada container
//           borderRadius: BorderRadius.circular(10),
//         ),

//         margin: const EdgeInsets.only(
//             bottom: 10, top: 2), // Atur jarak antara container
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: BgTumbuhan.primaryColor
//                     .withOpacity(0.1), // Warna biru pada bagian bawah
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(9.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                   ),
//                   child: Image.asset(
//                     plantList[index].imageURL,
//                     fit: BoxFit
//                         .contain, // Sesuaikan gambar agar tetap di dalam kotak biru
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: BgTumbuhan.primaryColor.withOpacity(0.5),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     plantList[index].category,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                       color: BgTumbuhan.blackColor,
//                     ),
//                   ),
//                   Text(
//                     plantList[index].plantName,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: BgTumbuhan.blackColor,
//                     ),
//                   ),
//                   Text(
//                     r'$' + plantList[index].price.toString(),
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                       color: BgTumbuhan.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:Florist/model/keranjang/data_keranjang.dart';
// // Import Plant class
// import 'package:Florist/views/color.dart';
// import 'package:flutter/material.dart';

// // late Future<ApiResponseKeranjang>
// //       _futureKeranjang; // Future untuk API data tanaman

// class KeranjangWidget extends StatelessWidget {
//   final DataKeranjang tanaman; // Gunakan Tanaman sebagai data keranjang

//   const KeranjangWidget({
//     Key? key,
//     required this.tanaman,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Tambahkan aksi yang diperlukan saat widget diklik
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         margin: const EdgeInsets.only(bottom: 10, top: 2),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         image: NetworkImage(tanaman.imageTanaman ?? ''), // Gunakan imageURL dari Tanaman
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         tanaman.namaTanaman ?? '', // Gunakan namaTanaman dari Tanaman
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Rp ${tanaman.quantity}',
//                         style: TextStyle(
//                           color: BgTumbuhan.primaryColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Rp ${tanaman.hargaTanaman}',
//                     style: TextStyle(
//                       color: BgTumbuhan.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:Florist/views/color.dart';

class KeranjangWidget extends StatelessWidget {
  final DataKeranjang
      dataKeranjang; // Gunakan DataKeranjang sebagai data keranjang

  const KeranjangWidget({
    Key? key,
    required this.dataKeranjang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tambahkan aksi yang diperlukan saat widget diklik
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(bottom: 10, top: 2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(dataKeranjang.imageTanaman ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataKeranjang.namaTanaman ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp ${dataKeranjang.hargaTanaman}',
                        style: TextStyle(
                          color: BgTumbuhan.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Rp ${dataKeranjang.quantity}',
                    style: TextStyle(
                      color: BgTumbuhan.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
