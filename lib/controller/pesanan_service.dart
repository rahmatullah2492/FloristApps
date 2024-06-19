import 'dart:convert';
import 'dart:io';
import 'package:Florist/model/pesanan/data.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class PesananService {
    // Get all pesanan
    Future<List<DataPesanan>> getPesananAll() async {
    final response = await http.get(Uri.parse('http://192.168.1.10:80/api/pesanans'));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DataPesanan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pesanan');
    }
  }

  // Get pesanan by id
  Future<DataPesanan> getPesananById(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.10:80/api/pesanans/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      return DataPesanan.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pesanan');
    }
  }

  // Create pesanan
  Future<void> createPesanan(int userId, double totalHarga, File buktiBayar, String status, List<Map<String, dynamic>> detailPesanan) async {
    var uri = Uri.parse('http://192.168.1.10:80/api/pesanans');
  
    // Prepare the payload
    Map<String, dynamic> payload = {
      'user_id': '$userId',
      'total_harga': totalHarga,
      'status': status,
      'detail_pesanan': detailPesanan,
    };

    // Create the multipart request
    var request = http.MultipartRequest('POST', uri);

    // Add fields to the request
    request.fields['user_id'] = payload['user_id'];
    request.fields['total_harga'] = payload['total_harga'].toString();
    request.fields['status'] = payload['status'];
    request.fields['detail_pesanan'] = jsonEncode(payload['detail_pesanan']);

    // Print the payload for debugging
    print('Payload: ${jsonEncode(payload)}');

    // Add the file to the request
    final mimeTypeData =
        lookupMimeType(buktiBayar.path, headerBytes: [0xFF, 0xD8])!.split('/');
    request.files.add(await http.MultipartFile.fromPath(
      'bukti_bayar',
      buktiBayar.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    ));

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        print('Pesanan berhasil dibuat');
        
      } else {
        final responseBody = await response.stream.bytesToString();
        print('Gagal membuat pesanan: ${response.statusCode}');
        print('Response body: $responseBody');
        throw Exception('Gagal membuat pesanan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
     
    }
  }

  // Delete pesanan by id
  Future<void> deletePesanan(int id) async {
    final response = await http.delete(Uri.parse('http://192.168.1.10:80/api/pesanans/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      // Pesanan berhasil dihapus, lakukan sesuatu jika perlu
      print('Pesanan berhasil dihapus');
    } else {
      // Gagal menghapus pesanan, tampilkan pesan kesalahan
      throw Exception('Gagal menghapus pesanan');
    }
  }
}
