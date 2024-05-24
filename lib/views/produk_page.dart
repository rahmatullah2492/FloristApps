import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:lottie/lottie.dart';
//import '../model/list_tumbuhan.dart';
//import '../widgets/plant_widget.dart';
import './pages.dart';

class ProdukPage extends StatefulWidget {
  //final RxList<Plant> favoritedPlants;

  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Baru'),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 4,
        shadowColor: BgTumbuhan.blackColor,
      ),
      //   body: Obx(
      //     () => widget.favoritedPlants.isEmpty
      //         ? Center(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 SizedBox(
      //                   height: 200,
      //                   child: Lottie.asset('assets/img/animasi_favorite.json'),
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text(
      //                   'Belum Ada Produk Baru',
      //                   style: TextStyle(
      //                     color: BgTumbuhan.primaryColor,
      //                     fontWeight: FontWeight.w300,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           )
      //         : Container(
      //             padding:
      //             const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      //             height: size.height * .5,
      //             child: ListView.builder(
      //               itemCount: widget.favoritedPlants.length,
      //               scrollDirection: Axis.vertical,
      //               physics: const BouncingScrollPhysics(),
      //               itemBuilder: (BuildContext context, int index) {

      //                 return PlantWidget(
      //                     index: index,
      //                     plantList: widget.favoritedPlants); // Perbaikan di sini
      //               },
      //             ),
      //           ),
      //   ),
    );
  }
}
