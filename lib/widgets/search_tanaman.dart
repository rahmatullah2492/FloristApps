import 'package:Florist/model/tanaman/api_respone.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
import 'package:Florist/views/color.dart';
import 'package:Florist/views/detail_tanaman.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeaerchTanaman extends SearchDelegate<String> {
  late Future<ApiResponseTanaman> _futureTanaman; // Define future for API data

  SeaerchTanaman(
      this._futureTanaman); // Constructor to receive future from caller

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context, '');
      },
    );
  }

  @override
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<ApiResponseTanaman>(
      future: _futureTanaman,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, bottom: 12, top: 15),
                  child: const Text(
                    'Tanaman Baru',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: snapshot.data!.tanaman?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _buildTanamanCard(snapshot.data!.tanaman![index]);
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: Text('No Data'));
        }
      },
    );
  }

  @override
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<ApiResponseTanaman>(
      future: _futureTanaman,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final List<DataTanaman> tanamanList = snapshot.data!.tanaman ?? [];
          final List<DataTanaman> filteredTanamanList =
              tanamanList.where((tanaman) {
            // Check if the name or category of the plant contains the search query
            return tanaman.namaTanaman!
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                tanaman.kategoriTanaman!
                    .toLowerCase()
                    .contains(query.toLowerCase());
          }).toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, bottom: 12, top: 15),
                  child: const Text(
                    'Search Results',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredTanamanList.length,
                  itemBuilder: (context, index) {
                    return _buildTanamanCard(filteredTanamanList[index]);
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: Text('No Data'));
        }
      },
    );
  }

  Widget _buildTanamanCard(DataTanaman tanaman) {
    return GestureDetector(
      onTap: () {
        // Menavigasi ke halaman detail dan meneruskan parameter tanaman
        Get.to(
          DetailTanaman(
            tanaman: tanaman,
          ),
          transition:
              Transition.downToUp, // Animasi transisi dari bawah ke atas
          duration: Duration(milliseconds: 450),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                tanaman.imageTanaman ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
