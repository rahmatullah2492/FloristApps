import 'package:Florist/model/keranjang/api_response.dart';
import 'package:get/get.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:Florist/controller/keranjang_service.dart';

class KeranjangController extends GetxController {
  var keranjangList = <DataKeranjang>[].obs;
  var totalHarga = 0.0.obs;
  var jumlahKeranjang = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKeranjang();
  }

  void fetchKeranjang() async {
    ApiResponseKeranjang response = await getKeranjang();
    if (response.error == null && response.keranjang != null) {
      keranjangList.assignAll(response.keranjang!);
      jumlahKeranjang.value = keranjangList.length;
      calculateTotalHarga();
    } else {
      // Handle error
    }
  }

  void deleteKeranjangItem(int id, DataKeranjang keranjang) async {
    ApiResponseKeranjang response = await deleteKeranjang(id);
    if (response.error == null) {
      keranjangList.remove(keranjang);
      calculateTotalHarga();
      jumlahKeranjang.value = keranjangList.length;
    } else {
      // Handle error
    }
  }

  void calculateTotalHarga() {
    totalHarga.value = keranjangList
        .where((item) => item.isChecked)
        .fold(0.0, (sum, item) => sum + (item.hargaTanaman ?? 0) * (item.quantity ?? 1));
  }
}
