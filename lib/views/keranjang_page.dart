import 'package:Florist/views/pages.dart';
import 'package:Florist/widgets/widgets.dart';
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
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    isCheckedList = List<bool>.filled(widget.addedToCartPlants.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Keranjang'),
        elevation: 4,
        shadowColor: BgTumbuhan.blackColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.addedToCartPlants.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Lottie.asset('assets/img/cart_plant.json'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Keranjang Anda',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: widget.addedToCartPlants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: PlantWidget(
                            index: index, plantList: widget.addedToCartPlants),
                        value: isCheckedList[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedList[index] = value!;
                          });
                        },
                      );
                    },
                  ),
          ),
          Container(
            height: 70,
            width: double.infinity,
            color: BgTumbuhan.blackColor.withOpacity(.05),
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Mengatur tata letak di sebelah kiri dan kanan
                children: [
                  Expanded(
                    flex: 2, // Lebih besar
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
                              'Rp 56.000',
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
                    flex: 1, // Lebih kecil
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          CheckoutPembelian(
                            addedToCartPlants: [],
                          ),
                          transition: Transition.downToUp,
                        );
                        // Handle action when Buy Now button is tapped
                      },
                      child: Container(
                        height: 100,
                        color: Color.fromARGB(255, 168, 7, 7),
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
        ],
      ),
    );
  }
}
