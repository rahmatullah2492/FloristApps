import 'package:Florist/controller/keranjang_service.dart';
import 'package:Florist/model/keranjang/api_response.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
import 'package:Florist/profile/page_profile.dart';
import 'package:Florist/views/color.dart';
import 'package:Florist/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class DetailTanaman extends StatefulWidget {
  final DataTanaman tanaman;

  const DetailTanaman({Key? key, required this.tanaman}) : super(key: key);

  @override
  _DetailTanamanState createState() => _DetailTanamanState();
}

class _DetailTanamanState extends State<DetailTanaman> {
  bool isSelected = false;

  // kode percobaaan

  void addToCart() async {
    setState(() {
      isSelected = !isSelected; // Perbarui isSelected saat tombol diklik
    });

    try {
      // Panggil fungsi addKeranjang
      ApiResponseKeranjang response = await addToKeranjang(
        widget.tanaman.namaTanaman!, // Nama tanaman (pastikan tidak null)
        1.toString(),
        1,  // Quantity (dalam bentuk int)
      );

      // Periksa apakah keranjang berhasil ditambahkan
      if (response.message != null) {
        print("Keranjang berhasil ditambahkan: ${response.message}");
      } else {
        // Tangani kesalahan
        print("Gagal menambahkan keranjang: ${response.error}");
      }
    } catch (error) {
      // Tangani kesalahan
      print("Gagal menambahkan keranjang: $error");
    }
  }

  // kode percobaaan

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: BgTumbuhan.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Get.to();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.message_outlined,
                      color: BgTumbuhan.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 90,
                    child: SizedBox(
                      height: 340,
                      child: Image.network(
                        widget.tanaman.imageTanaman ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //  Start Size Tanaman
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Size\n',
                                  style: TextStyle(
                                    color: BgTumbuhan.blackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.tanaman.sizeTanaman ?? ''}',
                                  style: TextStyle(
                                    color: BgTumbuhan.primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  End Size Tanaman

                          //  Start Kelembapan Tanaman
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Kelembapan\n',
                                  style: TextStyle(
                                    color: BgTumbuhan.blackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${widget.tanaman.kelembapanTanaman ?? ''}',
                                  style: TextStyle(
                                    color: BgTumbuhan.primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  end Kelembapan Tanaman

                          //  Start Suhu Tanaman
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Suhu\n',
                                  style: TextStyle(
                                    color: BgTumbuhan.blackColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.tanaman.suhuTanaman ?? ''}',
                                  style: TextStyle(
                                    color: BgTumbuhan.primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //  End Suhu Tanaman

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Stok\n',
                                  style: TextStyle(
                                    color: BgTumbuhan.primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${widget.tanaman.suhuTanaman ?? ''}',
                                  style: TextStyle(
                                    color: BgTumbuhan.blackColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 55, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: BgTumbuhan.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 230,
                              child: Text(
                                widget.tanaman.namaTanaman ?? '',
                                style: TextStyle(
                                  color: BgTumbuhan.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Rp. ${widget.tanaman.hargaTanaman ?? ''}',
                              style: TextStyle(
                                color: BgTumbuhan.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Start Kategori
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Kategory\n',
                                style: TextStyle(
                                  color: BgTumbuhan.blackColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: '${widget.tanaman.kategoriTanaman ?? ''}',
                                style: TextStyle(
                                  color: BgTumbuhan.primaryColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // End Kategori
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ReadMoreText(
                        widget.tanaman.deskripsiTanaman ?? '',
                        trimLines: 4,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Lainnya',
                        trimExpandedText: 'Sembunyikan',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: BgTumbuhan.blackColor,
                          fontSize: 18.0,
                        ),
                        moreStyle: TextStyle(
                          color: BgTumbuhan.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        lessStyle: TextStyle(
                          color: BgTumbuhan.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 85,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * .9,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                onPressed: addToCart, // Ubah di sini
                icon: Icon(
                  Icons.shopping_cart,
                  color: isSelected ? Colors.white : BgTumbuhan.primaryColor,
                ),
              ),
              decoration: BoxDecoration(
                color: isSelected ? BgTumbuhan.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: BgTumbuhan.primaryColor.withOpacity(.3),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.to(AkunSaya(), transition: Transition.downToUp);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: BgTumbuhan.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Beli',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
    );
  }
}

// void addToCart() {
//   setState(() {
//     isSelected = !isSelected;
//     if (isSelected) {
//       _cartList.add(widget.tanaman);
//     } else {
//       _cartList.remove(widget.tanaman);
//     }
//   });
// }


