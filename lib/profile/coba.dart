// import 'package:Florist/controller/tanaman_service.dart';
// import 'package:flutter/material.dart';
// import 'package:Florist/model/tanaman/api_respone.dart';
// import 'package:Florist/model/tanaman/data_tanaman.dart';

// class TanamanListPage extends StatefulWidget {
//   @override
//   _TanamanListPageState createState() => _TanamanListPageState();
// }

// class _TanamanListPageState extends State<TanamanListPage> {
//   late Future<ApiResponseTanaman> _futureTanaman;

//   @override
//   void initState() {
//     super.initState();
//     _futureTanaman = getTanaman();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Daftar Tanaman'),
//       ),
//       body: _tampilData(),
//     );
//   }

//   Widget _tampilData() {
//     return FutureBuilder<ApiResponseTanaman>(
//       future: _futureTanaman,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (snapshot.hasData) {
//           return _buildTanamanList(snapshot.data!.tanaman);
//         } else {
//           return Center(child: Text('No Data'));
//         }
//       },
//     );
//   }

//   Widget _buildTanamanList(List<DataTanaman>? tanamanList) {
//     return ListView.builder(
//       itemCount: tanamanList?.length ?? 0,
//       itemBuilder: (context, index) {
//         return _buildTanamanCard(tanamanList![index]);
//       },
//     );
//   }

//   Widget _buildTanamanCard(DataTanaman tanaman) {
//     return Card(
//       elevation: 3,
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       child: ListTile(
//         leading: Image.network(
//           tanaman.imageTanaman ?? '',
//           width: 80,
//           height: 80,
//           fit: BoxFit.cover,
//         ),
//         title: Text(tanaman.namaTanaman ?? ''),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 5),
//             Text('Nama: ${tanaman.namaTanaman ?? ''}'),
//             Text('Harga: ${tanaman.hargaTanaman ?? ''}'),
//             Text('Stok: ${tanaman.stokTanaman ?? ''}'),
//           ],
//         ),
//         onTap: () {
//           // Tambahkan logika untuk menangani ketika item tanaman diklik
//           // Misalnya, navigasi ke halaman detail tanaman
//         },
//       ),
//     );
//   }
// }

import 'package:Florist/controller/keranjang_service.dart';
import 'package:Florist/model/keranjang/api_response.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:flutter/material.dart';

class TanamanListPage extends StatefulWidget {
  @override
  _TanamanListPageState createState() => _TanamanListPageState();
}

class _TanamanListPageState extends State<TanamanListPage> {
  late Future<ApiResponseKeranjang> _futureKeranjang;

  @override
  void initState() {
    super.initState();
    _futureKeranjang = getKeranjang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tanaman'),
      ),
      body: _tampilData(),
    );
  }

  Widget _tampilData() {
    return FutureBuilder<ApiResponseKeranjang>(
      future: _futureKeranjang,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return _buildTanamanList(snapshot.data!.keranjang);
        } else {
          return Center(child: Text('No Data'));
        }
      },
    );
  }

  Widget _buildTanamanList(List<DataKeranjang>? keranjangList) {
    return ListView.builder(
      itemCount: keranjangList?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildTanamanCard(keranjangList![index]);
      },
    );
  }

  Widget _buildTanamanCard(DataKeranjang keranjang) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: Image.network(
          keranjang.imageTanaman ?? '',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(keranjang.namaTanaman ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text('Nama: ${keranjang.namaTanaman ?? ''}'),
            Text('Harga: ${keranjang.hargaTanaman ?? ''}'),
            Text('Stok: ${keranjang.hargaTanaman ?? ''}'),
          ],
        ),
        onTap: () {
          // Tambahkan logika untuk menangani ketika item tanaman diklik
          // Misalnya, navigasi ke halaman detail tanaman
        },
      ),
    );
  }
}
