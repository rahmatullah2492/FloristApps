import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/list_tumbuhan.dart';
import '../views/pages.dart';

class PlantWidget extends StatelessWidget {
  const PlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
  }) : super(key: key);

  final int index;
  final List<Plant> plantList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailPage(
            plantId: plantList[index].plantId,
          ),
          transition:
              Transition.downToUp, // Animasi transisi dari bawah ke atas
          duration: Duration(milliseconds: 450),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Warna cokelat pada container
          borderRadius: BorderRadius.circular(10),
        ),

        margin: const EdgeInsets.only(
            bottom: 10, top: 2), // Atur jarak antara container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: BgTumbuhan.primaryColor
                    .withOpacity(0.1), // Warna biru pada bagian bawah
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    plantList[index].imageURL,
                    fit: BoxFit
                        .contain, // Sesuaikan gambar agar tetap di dalam kotak biru
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: BgTumbuhan.primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantList[index].category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: BgTumbuhan.blackColor,
                    ),
                  ),
                  Text(
                    plantList[index].plantName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: BgTumbuhan.blackColor,
                    ),
                  ),
                  Text(
                    r'$' + plantList[index].price.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: BgTumbuhan.primaryColor,
                    ),
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
