import 'package:Florist/controller/tanaman_service.dart';
import 'package:Florist/model/tanaman/api_respone.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
import 'package:Florist/views/color.dart';
import 'package:Florist/views/detail_tanaman.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  // Future getTanaman
  late Future<ApiResponseTanaman> _futureTanaman;

  // Future getTanaman
  @override
  void initState() {
    super.initState();
    _futureTanaman = getTanaman();
  }

  // Future getTanaman
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tanaman Baru'),
        // elevation: 4,
        // shadowColor: BgTumbuhan.blackColor,
      ),
      body: _tampilData(),
    );
  }

  // FutureBuilder
  Widget _tampilData() {
    return FutureBuilder<ApiResponseTanaman>(
      future: _futureTanaman,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Tampilkan loading
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}')); // Tampilkan error
        } else if (snapshot.hasData) {
          return _buildTanamanGrid(
              snapshot.data!.tanaman); // Panggil fungsi _buildTanamanGrid
        } else {
          return Center(child: Text('No Data'));
        }
      },
    );
  }

  // GridView
  Widget _buildTanamanGrid(List<DataTanaman>? tanamanList) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // Tambahkan gridDelegate
        crossAxisCount: 2, // Tambahkan crossAxisCount
        crossAxisSpacing: 10, // Tambahkan crossAxisSpacing
        mainAxisSpacing: 10, // Tambahkan mainAxisSpacing
        childAspectRatio: 0.75, // Tambahkan childAspectRatio
      ),
      itemCount: tanamanList?.length ?? 0, // Tambahkan itemCount
      itemBuilder: (context, index) {
        // Tambahkan itemBuilder
        return _buildCard(tanamanList![index]); // Panggil fungsi _buildCard
      },
    );
  }

  Widget _buildCard(DataTanaman tanaman) {
    return GestureDetector(
      onTap: () {
        // Menavigasi ke halaman detail dan meneruskan parameter tanaman
        Get.to(DetailTanaman(
          tanaman: tanaman,
        ));
      },
      child: Card(
        elevation: 3, // Bayangan card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            Expanded(
              child: Image.network(
                tanaman.imageTanaman ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // text
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tanaman.namaTanaman ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(
                    'Rp: ${tanaman.hargaTanaman ?? ''}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: BgTumbuhan.primaryColor),
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
