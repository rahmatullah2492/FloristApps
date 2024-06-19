import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pesananpage extends StatefulWidget {
  const Pesananpage({Key? key}) : super(key: key);

  @override
  State<Pesananpage> createState() => _PesananpageState();
}

class _PesananpageState extends State<Pesananpage> {
  late Future<List<dynamic>> _futurePesanan;

  @override
  void initState() {
    super.initState();
    _futurePesanan = fetchPesanan();
  }

  Future<List<dynamic>> fetchPesanan() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.2:80/api/pesanans'));
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Gagal mengambil data pesanan');
    }
  }

  Future<void> createPesanan() async {
    final Map<String, dynamic> newPesanan = {
      'user_id': 1,
      'total_harga': 100000,
      'bukti_bayar': 'path/to/bukti_pembayaran.jpg',
      'status': 'pending',
      'detail_pesanan': [],
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.2:80/api/pesanans'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newPesanan),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pesanan berhasil dibuat'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal membuat pesanan: ${response.body}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futurePesanan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pesananList = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: pesananList.length,
              itemBuilder: (context, index) {
                final pesanan = pesananList[index];
                return ListTile(
                  title: Text('ID Pesanan: ${pesanan['id']}'),
                  subtitle: Text('Status: ${pesanan['status']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPesananPage(
                          pesanan: pesanan,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data pesanan'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createPesanan,
        tooltip: 'Buat Pesanan Baru',
        child: Icon(Icons.add),
      ),
    );
  }
}

class DetailPesananPage extends StatelessWidget {
  final Map<String, dynamic> pesanan;

  const DetailPesananPage({Key? key, required this.pesanan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailPesanan = pesanan['detail_pesanan'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('ID Pesanan: ${pesanan['id']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Harga: ${pesanan['total_harga']}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Status: ${pesanan['status']}'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Detail Pesanan:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: detailPesanan.length,
              itemBuilder: (context, index) {
                final detail = detailPesanan[index];
                return ListTile(
                  title: Text('Tanaman ID: ${detail['tanaman_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${detail['quantity']}'),
                      Text('Sub Harga: ${detail['sub_harga']}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
