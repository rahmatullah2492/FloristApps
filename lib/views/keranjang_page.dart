// ini khusus buat uji coba
import 'package:Florist/controller/keranjang_service.dart';
import 'package:Florist/model/keranjang/api_response.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:Florist/popup/pop_up.dart';
import 'package:Florist/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../model/list_tumbuhan.dart';

class KeranjangPage extends StatefulWidget {
  final List<Plant> addedToCartPlants;

  const KeranjangPage({
    Key? key,
    required this.addedToCartPlants,
  }) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  late Future<ApiResponseKeranjang> _futureKeranjang;
  List<DataKeranjang> _keranjangList = [];
  double _totalHarga = 0;
  // Variabel untuk menyimpan jumlah list keranjang
  int _jumlahKeranjang = 0;

  @override
  void initState() {
    super.initState();
    _futureKeranjang = getKeranjang();
    _futureKeranjang.then((response) {
      setState(() {
        _keranjangList = response.keranjang ?? [];
        _jumlahKeranjang = _keranjangList.length; // Update jumlah keranjang
      });
    });
  }

  void _deleteKeranjangItem(int? id, DataKeranjang keranjang) async {
    if (id == null) return;
    ApiResponseKeranjang response = await deleteKeranjang(id);
    if (response.error == null) {
      setState(() {
        _keranjangList.remove(keranjang);
        _totalHarga = _calculateTotalHarga(_keranjangList);
      });
    } else {
      // Handle error
      print(response.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('Keranjang'),
          SizedBox(width: 10),
          Text(
            '($_jumlahKeranjang)',
            style: TextStyle(fontSize: 20),
          )
        ],
      )),
      body: FutureBuilder<ApiResponseKeranjang>(
        future: _futureKeranjang,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            if (_keranjangList.isEmpty) {
              return _buildCartAnimation(); // Menampilkan animasi jika data kosong
            }
            return _buildList(_keranjangList);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildCartAnimation(); // Menampilkan animasi jika data kosong
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: Colors.grey.withOpacity(.1),
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Total:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Rp.${_totalHarga.toStringAsFixed(0)}', // Menampilkan total harga
                          style: TextStyle(
                            color: BgTumbuhan.primaryColor,
                            // Sesuaikan warna sesuai kebutuhan
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    // Cek apakah ada item yang dipilih
                    bool anyChecked =
                        _keranjangList.any((keranjang) => keranjang.isChecked);
                    // Jika ada item yang dipilih, pindah ke halaman checkout
                    if (anyChecked) {
                      Get.to(
                        CheckoutPembelian(
                          addedToCartPlants: [],
                        ),
                        transition: Transition
                            .downToUp, // Animasi transisi dari bawah ke atas
                        duration: Duration(milliseconds: 450),
                      );
                    } else if (_keranjangList.isNotEmpty) {
                      // Jika tidak ada item yang dipilih, tampilkan pesan
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'Pilih setidaknya satu item untuk checkout',
                      ));
                      //Get.snackbar('Pilih setidaknya satu item untuk checkout', '');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                        'Keranjang kosong, Tidak ada item untuk checkout',
                      ));
                      // Jika keranjang kosong
                      //Get.snackbar('Keranjang kosong', 'Tidak ada item untuk checkout');
                    }
                  },
                  child: Container(
                    height: 100,
                    color: Colors.red, // Sesuaikan warna sesuai kebutuhan
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Metode untuk membangun daftar item keranjang
  Widget _buildList(List<DataKeranjang> keranjangList) {
    return ListView.builder(
      itemCount: keranjangList.length,
      itemBuilder: (context, index) {
        return _buildListKeranjang(keranjangList[index]);
      },
    );
  }

  // Metode untuk membangun tampilan item keranjang
  Widget _buildListKeranjang(DataKeranjang keranjang) {
    int quantity = keranjang.quantity ?? 0;
    int hargaTanaman = keranjang.hargaTanaman ?? 0;
    //int totalHargaItem = quantity * hargaTanaman;
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color:
                  Colors.grey), // Warna dan ketebalan garis sesuaikan kebutuhan
        ),
        height: 150,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 130,
                    decoration: BoxDecoration(
                      color: BgTumbuhan.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(keranjang.imageTanaman ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                                keranjang.namaTanaman ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: BgTumbuhan.primaryColor),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Rp.$hargaTanaman',
                              style: TextStyle(
                                color: Colors
                                    .grey, // Sesuaikan warna sesuai kebutuhan
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Container(
                      width: 123,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.remove),
                                  iconSize: 20,
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;
                                        keranjang.quantity = quantity;
                                        if (keranjang.isChecked) {
                                          _totalHarga = _calculateTotalHarga(
                                              _keranjangList);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 20,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                      keranjang.quantity = quantity;
                                      if (keranjang.isChecked) {
                                        _totalHarga = _calculateTotalHarga(
                                            _keranjangList);
                                      }
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    _deleteKeranjangItem(
                                        keranjang.id, keranjang);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: Checkbox(
                value: keranjang.isChecked,
                activeColor: BgTumbuhan.primaryColor,
                onChanged: (isChecked) {
                  setState(() {
                    keranjang.isChecked = isChecked ?? false;
                    _totalHarga = _calculateTotalHarga(_keranjangList);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk menghitung total harga
  double _calculateTotalHarga(List<DataKeranjang> keranjangList) {
    double total = 0;
    for (var item in keranjangList) {
      if (item.isChecked) {
        total +=
            (item.hargaTanaman ?? 0) * (item.quantity ?? 1); // Menghitung total
      }
    }
    return total;
  }

  // dipanggil ketika data kosong
  Widget _buildCartAnimation() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset('assets/img/cart_plant.json'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Belum ada tanaman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: BgTumbuhan.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:Florist/model/keranjang/data_keranjang.dart';
// import 'package:Florist/views/color.dart';
// import 'package:Florist/widgets/keranjang_widget.dart';
// import 'package:lottie/lottie.dart';

// class KeranjangPage extends StatefulWidget {
//   final List<DataKeranjang> addedToCartPlants; // Menggunakan DataKeranjang sebagai tipe list

//   const KeranjangPage({
//     Key? key,
//     required this.addedToCartPlants,
//   }) : super(key: key);

//   @override
//   State<KeranjangPage> createState() => _KeranjangPageState();
// }

// class _KeranjangPageState extends State<KeranjangPage> {
//   List<bool> isCheckedList = [];

//   @override
//   void initState() {
//     super.initState();
//     isCheckedList = List<bool>.filled(widget.addedToCartPlants.length, false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text('Keranjang'),
//         elevation: 4,
//         shadowColor: BgTumbuhan.blackColor,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: widget.addedToCartPlants.isEmpty
//                 ? Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 200,
//                           child: Lottie.asset('assets/img/cart_plant.json'),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Keranjang Anda',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w300,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ):
//           ),
//           Container(
//             height: 70,
//             width: double.infinity,
//             color: BgTumbuhan.blackColor.withOpacity(.05),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       height: 100,
//                       color: Colors.white,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(left: 12),
//                             child: Text(
//                               'Total:',
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 12),
//                             child: Text(
//                               'Rp 56.000', // Anda mungkin perlu menyesuaikan ini dengan total harga sesuai kebutuhan
//                               style: TextStyle(
//                                 color: BgTumbuhan.primaryColor,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: InkWell(
//                       onTap: () {
//                         // Handle action when Buy Now button is tapped
//                       },
//                       child: Container(
//                         height: 100,
//                         color: Color.fromARGB(255, 168, 7, 7),
//                         child: Center(
//                           child: Text(
//                             'Checkout',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:Florist/controller/keranjang_service.dart';
// import 'package:Florist/model/keranjang/api_response.dart';
// import 'package:Florist/model/keranjang/data_keranjang.dart';
// import 'package:flutter/material.dart';
// import '../model/list_tumbuhan.dart';

// class KeranjangPage extends StatefulWidget {
//   final List<Plant> addedToCartPlants;

//   const KeranjangPage({
//     Key? key,
//     required this.addedToCartPlants,
//   }) : super(key: key);

//   @override
//   State<KeranjangPage> createState() => _KeranjangPageState();
// }

// class _KeranjangPageState extends State<KeranjangPage> {
//   late Future<ApiResponseKeranjang> _futureKeranjang;
//   List<DataKeranjang> _keranjangList = [];
//   double _totalHarga = 0;

//   @override
//   void initState() {
//     super.initState();
//     _futureKeranjang = getKeranjang();
//     _futureKeranjang.then((response) {
//       setState(() {
//         _keranjangList = response.keranjang ?? [];
//         _totalHarga = _calculateTotalHarga(_keranjangList);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text('Keranjang'),
//       ),
//       body: FutureBuilder<ApiResponseKeranjang>(
//         future: _futureKeranjang,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return _buildList(_keranjangList);
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return Center(child: Text('No Data'));
//           }
//         },
//       ),
//       bottomNavigationBar: Container(
//         height: 70,
//         width: double.infinity,
//         color: Colors.grey.withOpacity(.1),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   height: 100,
//                   color: Colors.white,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 12),
//                         child: Text(
//                           'Total:',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12),
//                         child: Text(
//                           'Rp $_totalHarga', // Menampilkan total harga
//                           style: TextStyle(
//                             color: Colors.green, // Sesuaikan warna sesuai kebutuhan
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: InkWell(
//                   onTap: () {
//                     // Tambahkan aksi saat tombol Checkout ditekan
//                   },
//                   child: Container(
//                     height: 100,
//                     color: Colors.blue, // Sesuaikan warna sesuai kebutuhan
//                     child: Center(
//                       child: Text(
//                         'Checkout',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Metode untuk membangun daftar item keranjang
//   Widget _buildList(List<DataKeranjang> keranjangList) {
//     return ListView.builder(
//       itemCount: keranjangList.length,
//       itemBuilder: (context, index) {
//         return _buildListKeranjang(keranjangList[index]);
//       },
//     );
//   }

//   // Metode untuk membangun tampilan item keranjang
//   Widget _buildListKeranjang(DataKeranjang keranjang) {
//     //int quantity = keranjang.quantity ?? 0;
//     int hargaTanaman = keranjang.hargaTanaman ?? 0;
//     //int totalHargaItem = quantity * hargaTanaman;

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     image: NetworkImage(keranjang.imageTanaman ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     keranjang.namaTanaman ?? '',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Rp $hargaTanaman',
//                     style: TextStyle(
//                       color: Colors.grey, // Sesuaikan warna sesuai kebutuhan
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Checkbox(
//                     value: keranjang.isChecked,
//                     onChanged: (isChecked) {
//                       setState(() {
//                         keranjang.isChecked = isChecked ?? false;
//                         _totalHarga = _calculateTotalHarga(_keranjangList);
//                       });
//                     },
//                   ),
//                   // Text('Rp $totalHargaItem'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Metode untuk menghitung total harga
//   double _calculateTotalHarga(List<DataKeranjang> keranjangList) {
//     double total = 0;
//     for (var keranjang in keranjangList) {
//       if (keranjang.isChecked) {
//         total += (keranjang.hargaTanaman ?? 0) * (keranjang.quantity ?? 0);
//       }
//     }
//     return total;
//   }
// }

// ini khusus buat uji coba
// import 'package:Florist/controller/keranjang_service.dart';
// import 'package:Florist/model/keranjang/api_response.dart';
// import 'package:Florist/model/keranjang/data_keranjang.dart';
// import 'package:Florist/views/pages.dart';
// import 'package:flutter/material.dart';
// import '../model/list_tumbuhan.dart';

// class KeranjangPage extends StatefulWidget {
//   final List<Plant> addedToCartPlants;

//   const KeranjangPage({
//     Key? key,
//     required this.addedToCartPlants,
//   }) : super(key: key);

//   @override
//   State<KeranjangPage> createState() => _KeranjangPageState();
// }

// class _KeranjangPageState extends State<KeranjangPage> {
//   late Future<ApiResponseKeranjang> _futureKeranjang;
//   List<DataKeranjang> _keranjangList = [];
//   double _totalHarga = 0;

//   @override
//   void initState() {
//     super.initState();
//     _futureKeranjang = getKeranjang();
//     _futureKeranjang.then((response) {
//       setState(() {
//         _keranjangList = response.keranjang ?? [];
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         shadowColor: Colors.black.withOpacity(.1),
//         title: Text('Keranjang'),
//       ),
//       body: FutureBuilder<ApiResponseKeranjang>(
//         future: _futureKeranjang,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return _buildList(_keranjangList);
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return Center(child: Text('No Data'));
//           }
//         },
//       ),
//       bottomNavigationBar: Container(
//         height: 70,
//         width: double.infinity,
//         color: Colors.grey.withOpacity(.1),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 2),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   height: 100,
//                   color: Colors.white,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(left: 12),
//                         child: Text(
//                           'Total:',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 12),
//                         child: Text(
//                           'Rp $_totalHarga', // Menampilkan total harga
//                           style: TextStyle(
//                             color: BgTumbuhan.primaryColor,
//                             // Sesuaikan warna sesuai kebutuhan
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: InkWell(
//                   onTap: () {
//                     // Tambahkan aksi saat tombol Checkout ditekan
//                   },
//                   child: Container(
//                     height: 100,
//                     color: Colors.blue, // Sesuaikan warna sesuai kebutuhan
//                     child: Center(
//                       child: Text(
//                         'Checkout',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Metode untuk membangun daftar item keranjang
//   Widget _buildList(List<DataKeranjang> keranjangList) {
//     return ListView.builder(
//       itemCount: keranjangList.length,
//       itemBuilder: (context, index) {
//         return _buildListKeranjang(keranjangList[index]);
//       },
//     );
//   }

//   // Metode untuk membangun tampilan item keranjang
//   Widget _buildListKeranjang(DataKeranjang keranjang) {
//     int quantity = keranjang.quantity ?? 0;
//     int hargaTanaman = keranjang.hargaTanaman ?? 0;
//     //int totalHargaItem = quantity * hargaTanaman;
//     return Padding(
//       padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(
//               color:
//                   Colors.grey), // Warna dan ketebalan garis sesuaikan kebutuhan
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: BgTumbuhan.primaryColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                     image: NetworkImage(keranjang.imageTanaman ?? ''),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 40),
//                 child: Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           keranjang.namaTanaman ?? '',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Rp $hargaTanaman',
//                           style: TextStyle(
//                             color:
//                                 Colors.grey, // Sesuaikan warna sesuai kebutuhan
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],

//                 ),

//               ),

//               Padding(
//                 padding: const EdgeInsets.only(top: 52),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Container(
//                           width: 30,
//                           height: 30,
//                           decoration: BoxDecoration(

//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(2),

//                           ),
//                           child: IconButton(
//                             padding: EdgeInsets.zero,
//                             icon: Icon(Icons.remove),
//                             iconSize: 20,
//                             onPressed: () {
//                               setState(() {
//                                 if (quantity > 1) {
//                                   quantity--;
//                                   keranjang.quantity = quantity;
//                                   if (keranjang.isChecked) {
//                                     _totalHarga =
//                                         _calculateTotalHarga(_keranjangList);
//                                   }
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         Container(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: Text(
//                             '$quantity',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                         Container(
//                           width: 30,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: IconButton(
//                             padding: EdgeInsets.zero,
//                             iconSize: 20,
//                             icon: Icon(Icons.add),
//                             onPressed: () {
//                               setState(() {
//                                 quantity++;
//                                 keranjang.quantity = quantity;
//                                 if (keranjang.isChecked) {
//                                   _totalHarga =
//                                       _calculateTotalHarga(_keranjangList);
//                                 }
//                               });
//                             },
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Icon(
//                           Icons.delete,
//                           color: Colors.grey,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Metode untuk menghitung total harga
//   double _calculateTotalHarga(List<DataKeranjang> keranjangList) {
//     double total = 0;
//     for (var item in keranjangList) {
//       if (item.isChecked) {
//         total += (item.hargaTanaman ?? 0) * (item.quantity ?? 1);
//       }
//     }
//     return total;
//   }
// }
