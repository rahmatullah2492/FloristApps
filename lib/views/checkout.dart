import 'package:flutter/material.dart';
import '../model/list_tumbuhan.dart';
import '../views/pages.dart';
import '../widgets/widgets.dart';

class CheckoutPembelian extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CheckoutPembelian({
    Key? key,
    required this.addedToCartPlants,
  }) : super(key: key);

  @override
  State<CheckoutPembelian> createState() => _CheckoutPembelianState();
}

class _CheckoutPembelianState extends State<CheckoutPembelian> {
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
        // automaticallyImplyLeading: false,
        title: Text('Checkout'),
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.addedToCartPlants.isEmpty
                ? Center()
                : ListView.builder(
                    itemCount: widget.addedToCartPlants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: PlantWidget(
                            index: index, plantList: widget.addedToCartPlants),
                        value: isCheckedList[index],
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isCheckedList[index] = value!;
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
          Container(
            height: 70, // Tinggi
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
                        // logika untuk checkout
                      },
                      child: Container(
                        height: 100,
                        color: Colors.red,
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
