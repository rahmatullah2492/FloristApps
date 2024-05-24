import 'package:Florist/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/list_tumbuhan.dart';
import '../views/pages.dart';
import '../widgets/plant_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size mediaSize; // Ukuran media layar.
  int selectedIndex = 0;

  List<Plant> _plantList = Plant.plantList;

  List<String> _plantTypes = [
    // 'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  BottomNavBarController _controller = Get.find<
      BottomNavBarController>(); // Menambahkan referensi ke BottomNavBarController

  void toggleIsFavorated(int index) {
    setState(() {
      if (!_plantList[index].isFavorated) {
        _plantList[index].isFavorated = true;
        _controller.favorites
            .add(_plantList[index]); // Menambahkan ke daftar favorit
      } else {
        _plantList[index].isFavorated = false;
        _controller.favorites
            .remove(_plantList[index]); // Menghapus dari daftar favorit
      }
    });
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
                ChatPage(),
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
                // Aksi ketika ikon pencarian ditekan
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
            // Aksi ketika teks input berubah
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
      child: ListView.builder(
        itemCount: _plantList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => DetailPage(
                  plantId: _plantList[index].plantId,
                ),
                transition:
                    Transition.downToUp, // Animasi transisi dari bawah ke atas
                duration: Duration(milliseconds: 450),
              );
            },
            child: Container(
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        onPressed: () {
                          toggleIsFavorated(index);
                        },
                        icon: Icon(
                          _plantList[index].isFavorated == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: BgTumbuhan.primaryColor,
                        ),
                        iconSize: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 50,
                    child: Image.asset(
                        _plantList[index].imageURL), // ini adalah gambar
                  ),
                  Positioned(
                    bottom: 15,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _plantList[index].category, // ini adalah kategorinya
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _plantList[index].plantName, // ini adalah namanya
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
                        r'$' +
                            _plantList[index]
                                .price
                                .toString(), // menambahkan  teks harga
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
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextNew() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // membuat tempat teks
          padding: const EdgeInsets.only(left: 16, bottom: 15, top: 15),
          child: const Text(
            'Tanaman Baru',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Column(
          // membuat grid
          children: [
            SizedBox(
              child: Column(
                children: List.generate(
                  (_plantList.length / 2).ceil(), // Jumlah baris
                  (rowIndex) {
                    final int startIndex = rowIndex * 2;
                    final int endIndex = startIndex + 2 < _plantList.length
                        ? startIndex + 2
                        : _plantList.length;
                    return Row(
                      children: List.generate(endIndex - startIndex, (index) {
                        final int itemIndex = startIndex + index;
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: PlantWidget(
                              index: itemIndex,
                              plantList: _plantList,
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
