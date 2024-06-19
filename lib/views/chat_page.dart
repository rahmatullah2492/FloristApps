// import 'package:Florist/controller/pesanan_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'pages.dart';
// // Import kelas PesananService

// class ChatPage extends StatefulWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final PesananService _pesananService = PesananService();
//   List<dynamic>? _pesanans; // Change to nullable list

//   @override
//   void initState() {
//     super.initState();
//     _getPesananList();
//   }

//   Future<void> _getPesananList() async {
//     try {
//       print("Fetching pesanan...");
//       final pesanans = await _pesananService.getAllPesanan();
//       print("Pesanans fetched: $pesanans");
//       setState(() {
//         _pesanans = pesanans; // Assign fetched data to _pesanans
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildHomeNotification(),
//       body: _buildBackground(),
//     );
//   }

//   PreferredSizeWidget _buildHomeNotification() {
//     return PreferredSize(
//       preferredSize: Size.fromHeight(kToolbarHeight),
//       child: AppBar(
//         backgroundColor: Colors.white,
//         shadowColor: BgTumbuhan.blackColor,
//         elevation: 4,
//         title: Text(
//           'Chat',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.notifications,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               // Handle notifications button press
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.message,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Get.to(ChatPage());
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBackground() {
//   return _pesanans == null || _pesanans!.isEmpty
//       ? Center(child: Text('Tidak ada pesanan'))
//       : ListView.separated(
//           itemCount: _pesanans!.length,
//           separatorBuilder: (BuildContext context, int index) => Divider(),
//           itemBuilder: (BuildContext context, int index) {
//             final pesanan = _pesanans![index];
//             final detailPesanan = pesanan['detail_pesanan'];

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Pesanan #${index + 1}',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text('Total harga: Rp ${pesanan['total_harga']}'),
//                 SizedBox(height: 8),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: detailPesanan.length,
//                   itemBuilder: (BuildContext context, int idx) {
//                     final tanaman = detailPesanan[idx];
//                     return Row(
//                       children: [
//                         SizedBox(width: 8),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('User_Id: ${pesanan['user_id']}'),
//                             Text(tanaman['nama_tanaman']),
//                             Text('Harga: Rp ${tanaman['sub_harga']}'),
//                             Text('Quantity: ${tanaman['quantity']}'),
//                             Text('Status: ${pesanan['status']}'),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
// }

// }
