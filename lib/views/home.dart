//import 'package:Florist/controller/bottom_nav_controller.dart';
import 'package:Florist/controller/tanaman_service.dart';
import 'package:Florist/model/tanaman/api_respone.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
import 'package:Florist/profile/pesanan.dart';
import 'package:Florist/views/detail_tanaman.dart';
import 'package:Florist/widgets/search_tanaman.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size mediaSize; // Ukuran media layar.
  int selectedIndex = 0;

  //List<Plant> _plantList = Plant.plantList;

  List<String> _plantTypes = [
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  //BottomNavBarController _controller = Get.find<
  // BottomNavBarController>(); // Menambahkan referensi ke BottomNavBarController
  late Future<ApiResponseTanaman>
      _futureTanaman; // Future untuk API data tanaman

  @override
  void initState() {
    super.initState();
    _futureTanaman = getTanaman();
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BackgroundPutih.build(), // Background Putih
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHomeNotification(),
          ),
          Positioned.fill(
            child: _buildBackground(),
          ),
          Positioned(child: _buildSearch()),
        ],
      ),
    );
  }

  Widget _buildHomeNotification() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: Row(
          children: [
            Text(
              'Home',
              style: TextStyle(color: Colors.black),
            ), // Menyesuaikan warna teks
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.black,
            ), // Menyesuaikan warna ikon
            onPressed: () {
              Get.to(
                // ChatPage(),
                Pesananpage(),
                transition: Transition.downToUp,
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor:
            Colors.white, // Membuat AppBar dengan latar belakang putih
        elevation: 0, // Menghilangkan bayangan AppBar saat discroll
        shadowColor: Colors.transparent, // Menghilangkan warna bayangan
        automaticallyImplyLeading: false, // Menghilangkan icon kembali (back)
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  Widget _buildBackground() {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Container(
        width: mediaSize.width,
        color: Colors.white,
        child: _buildForm(),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: BgTumbuhan.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Do nothing when the search icon is tapped
              },
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                // Aksi ketika tombol mikrofon ditekan
              },
            ),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          onChanged: (value) {
            // Do nothing when text changes
          },
          onTap: () {
            // Call showSearch when the text field is tapped
            showSearch(
                context: context, delegate: SeaerchTanaman(getTanaman()));
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCrossCategory(),
          _buildScrolTumbuhan(),
          _buildTextNew(),
        ],
      ),
    );
  }

  Widget _buildCrossCategory() {
    // Menambahkan widget _buildCrossCategory teks
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 50.0,
        width: mediaSize.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _plantTypes.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Text(
                  _plantTypes[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: selectedIndex == index
                        ? FontWeight.bold
                        : FontWeight.w300,
                    color: selectedIndex == index
                        ? BgTumbuhan.primaryColor
                        : BgTumbuhan.blackColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildScrolTumbuhan() {
    return SizedBox(
      height: mediaSize.height * .3,
      child: FutureBuilder<ApiResponseTanaman>(
        future: _futureTanaman,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.tanaman!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final DataTanaman tanaman = snapshot.data!.tanaman![index];
                
                
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => DetailTanaman(
                         tanaman: tanaman,
                      ),
                      transition: Transition.downToUp,
                      duration: Duration(milliseconds: 450),
                    );
                  },
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      children: [
                        // Menampilkan gambar tanaman dari URL
                        Positioned(
                          left: 50,
                          right: 50,
                          top: 20,
                          bottom: 50,
                          child: Image.network(
                            tanaman.imageTanaman ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tanaman.kategoriTanaman ??
                                    '', // Kategori tanaman
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),

                              Text(
                                tanaman.namaTanaman ?? '', // Nama tanaman
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Rp: ${tanaman.hargaTanaman ?? ''}', // Harga tanaman
                              style: TextStyle(
                                color: BgTumbuhan.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: BgTumbuhan.primaryColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }

  Widget _buildTextNew() {
    return FutureBuilder<ApiResponseTanaman>(
      future: _futureTanaman,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Column(
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
                itemCount: snapshot.data!.tanaman?.length ??
                    0, // Perhatikan penggunaan "??" untuk menangani daftar yang mungkin null
                itemBuilder: (context, index) {
                  return _buildTanamanCard(snapshot.data!.tanaman![
                      index]); // Mengambil elemen tertentu dari daftar
                },
              ),
            ],
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



















  // void toggleIsFavorated(int index) {
  //   setState(() {
  //     if (!_plantList[index].isFavorated) {
  //       _plantList[index].isFavorated = true;
  //       _controller.favorites
  //           .add(_plantList[index]); // Menambahkan ke daftar favorit
  //     } else {
  //       _plantList[index].isFavorated = false;
  //       _controller.favorites
  //           .remove(_plantList[index]); // Menghapus dari daftar favorit
  //     }
  //   });
  // }