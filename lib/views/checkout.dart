import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:Florist/controller/user_service.dart';
import 'package:Florist/views/color.dart';

class CheckoutPembelian extends StatefulWidget {
  final List<DataKeranjang> addedToCartPlants;
  final double totalHarga;

  const CheckoutPembelian({
    Key? key,
    required this.addedToCartPlants,
    required this.totalHarga,
  }) : super(key: key);

  @override
  _CheckoutPembelianState createState() => _CheckoutPembelianState();
}

class _CheckoutPembelianState extends State<CheckoutPembelian> {
  late Future<ApiResponseUsers> _futureUser;
  File? _image;
  int? userId;

  @override
  void initState() {
    super.initState();
    _futureUser = UserService().getUser();
    _futureUser.then((response) {
      setState(() {
        userId = response.data?.id;
      });
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> makePostRequest() async {
    if (userId == null) {
      print('User ID is null');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User ID belum tersedia.')));
      return;
    }
    if (_image == null) {
      print('Image is null');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Silakan pilih gambar terlebih dahulu.')));
      return;
    }

    final url = Uri.parse('http://192.168.1.10:80/api/pesanans');
    final request = http.MultipartRequest('POST', url);

    request.fields['user_id'] = userId.toString();
    request.fields['total_harga'] = widget.totalHarga.toStringAsFixed(0);
    request.fields['status'] = 'completed';

    for (var i = 0; i < widget.addedToCartPlants.length; i++) {
      final plant = widget.addedToCartPlants[i];
      request.fields['detail_pesanan[$i][tanaman_id]'] = plant.id.toString();
      request.fields['detail_pesanan[$i][nama_tanaman]'] =
          plant.namaTanaman ?? '';
      request.fields['detail_pesanan[$i][quantity]'] =
          plant.quantity.toString();
      request.fields['detail_pesanan[$i][sub_harga]'] =
          (plant.hargaTanaman! * plant.quantity!).toString();
    }

    request.files
        .add(await http.MultipartFile.fromPath('bukti_bayar', _image!.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        print('Request successful');
        print('Response body: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permintaan berhasil dikirim.')));
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Request failed with status: ${response.statusCode}');
        print('Response body: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengirim permintaan.')));
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: Text('Checkout'),
        elevation: 4,
      ),
      body: FutureBuilder<ApiResponseUsers>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!.data;
            userId = user?.id;

            return Column(
              children: [
                Container(
                  color: Colors.green[50],
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.green),
                      SizedBox(width: 8.0),
                      Text(
                        'Berhasil mendapatkan Gratis Ongkir',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                      border: Border(),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.location_on, color: Colors.red),
                      title: Text('Alamat Pengiriman'),
                      subtitle: Text(
                        '${user!.name?.toUpperCase()} | ${user.noTelp}\n${user.alamatRumah}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.addedToCartPlants.length,
                    itemBuilder: (context, index) {
                      final plant = widget.addedToCartPlants[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12.0),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                            border: Border(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: BgTumbuhan.primaryColor
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Image.network(
                                        plant.imageTanaman ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant.namaTanaman ?? '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Rp ${plant.hargaTanaman ?? ''}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'x${plant.quantity ?? ''} pcs',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7, left: 140),
                                      child: Text(
                                        'Total: Rp ${(plant.hargaTanaman ?? 0) * (plant.quantity ?? 0)}',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.green[50],
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.payment, color: Colors.black),
                            SizedBox(width: 8.0),
                            Text(
                              'Metode Pembayaran',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('BRI',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text('0021 0124 8821 509 ',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('MANDIRI',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text('0561 0325 8821 345 ',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                          color: Colors.green[50],
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.list, color: Colors.black),
                              SizedBox(width: 8.0),
                              Text(
                                'Rincian Pesanan',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Total Pesanan (${widget.addedToCartPlants.length} Produk):',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text('Rp ${widget.totalHarga.toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Pembayaran:',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Text('Rp ${widget.totalHarga.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Column(
                  children: [
                    if (_image != null)
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              _image!,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: InkWell(
                              onTap: _removeImage,
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(right: 3, left: 3),
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          height: 60,
                          color: BgTumbuhan.primaryColor,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload, color: Colors.white),
                                SizedBox(width: 8.0),
                                Text(
                                  'Upload Bukti Pembayaran',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('No user data'));
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: BgTumbuhan.blackColor.withOpacity(.05),
        child: Padding(
          padding: const EdgeInsets.only(top: 2, left: 3, right: 3),
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
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Rp ${widget.totalHarga.toStringAsFixed(0)}',
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
                    makePostRequest(); // Memanggil metode makePostRequest
                  },
                  child: Container(
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        'Buat Pesanan',
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
}
