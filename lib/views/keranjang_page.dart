import 'package:Florist/controller/keranjang_service.dart';
import 'package:Florist/model/keranjang/api_response.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
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
    required this.addedToCartPlants
  }) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
  
}


class _KeranjangPageState extends State<KeranjangPage> {
   final DataTanaman dataTanamanku = Get.put(DataTanaman());
  
  late Future<ApiResponseKeranjang> _futureKeranjang;
  List<DataKeranjang> _keranjangList = [];
 // late int tanamanId; // tanamanId di sini

  double _totalHarga = 0;
  int _jumlahKeranjang = 0;
  int _selectedItemCount = 0;

  @override
  void initState() {
    super.initState();
    _futureKeranjang = getKeranjang();

    _futureKeranjang.then((response) {
      setState(() {
        _keranjangList = response.keranjang ?? [];
        _jumlahKeranjang = _keranjangList.length;
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
      print(response.error);
    }
  }

  // Mengirim pesanan ke halaman checkout

  void sendOrderToCheckout(List<DataKeranjang> keranjangList) {
    Get.to(
      CheckoutPembelian(
        addedToCartPlants:
            keranjangList.where((keranjang) => keranjang.isChecked).toList(),
        totalHarga: _totalHarga, // Mengirim total harga
      ),
      transition: Transition.downToUp,
      duration: Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text('Keranjang Saya'),
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
              return _buildCartAnimation();
            }
            return _buildList(_keranjangList);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return _buildCartAnimation();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
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
                          'Rp.${_totalHarga.toStringAsFixed(0)}',
                          style: TextStyle(
                            color: BgTumbuhan.primaryColor,
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
                      sendOrderToCheckout(_keranjangList);
                    } else if (_keranjangList.isNotEmpty) {
                      // Cek apakah keranjang tidak kosong
                      // Jika tidak ada item yang dipilih, tampilkan pesan
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar(
                            'Pilih setidaknya satu item untuk checkout'),
                      );
                    } else {
                      // Cek apakah keranjang kosong
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnackBar(
                            'Keranjang kosong, Tidak ada item untuk checkout'),
                      );
                    }
                  },
                  child: Container(
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Checkout(${_selectedItemCount})',
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

  Widget _buildList(List<DataKeranjang> keranjangList) {
    return ListView.builder(
      itemCount: keranjangList.length,
      itemBuilder: (context, index) {
        return _buildListKeranjang(keranjangList[index]);
      },
    );
  }

  void _updateSelectedItemCount() {
    setState(() {
      _selectedItemCount =
          _keranjangList.where((item) => item.isChecked).length;
    });
  }

  Widget _buildListKeranjang(DataKeranjang keranjang) {
    int quantity = keranjang.quantity ?? 0;
    int hargaTanaman = keranjang.hargaTanaman ?? 0;
    
    

    // Validasi nilai tanamanId sebelum mencetaknya
    if (keranjang.tanamanId != null && keranjang.tanamanId! > 0) {
      print('Id Tanaman: ${keranjang.tanamanId}');
    } else {
      print('Id Tanaman tidak valid');
    }

    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
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
                      color: BgTumbuhan.primaryColor.withOpacity(0),
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
                                color: Colors.grey,
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
                                          _updateSelectedItemCount();
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
                                        _updateSelectedItemCount();
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
                    _updateSelectedItemCount();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  double _calculateTotalHarga(List<DataKeranjang> keranjangList) {
    double total = 0;
    for (var item in keranjangList) {
      if (item.isChecked) {
        total += (item.hargaTanaman ?? 0) * (item.quantity ?? 1);
      }
    }
    return total;
  }

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
