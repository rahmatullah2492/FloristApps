import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Florist/controller/bottom_nav_controller.dart';
import 'package:Florist/model/list_tumbuhan.dart';
import './pages.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Plant> _plantList = Plant.plantList;

  BottomNavBarController _controller = Get.find<BottomNavBarController>();

  void toggleIsFavorated(int index) {
    setState(() {
      if (!_plantList[index].isFavorated) {
        _plantList[index].isFavorated = true;
        _controller.favorites.add(_plantList[index]);
      } else {
        _plantList[index].isFavorated = false;
        _controller.favorites.remove(_plantList[index]);
      }
    });
  }

  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

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
                      color: BgTumbuhan.primaryColor.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: BgTumbuhan.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    toggleIsFavorated(widget.plantId);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: BgTumbuhan.primaryColor.withOpacity(.15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        toggleIsFavorated(widget.plantId);
                      },
                      icon: Icon(
                        _plantList[widget.plantId].isFavorated == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: BgTumbuhan.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                      child: Image.asset(_plantList[widget.plantId].imageURL),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Size',
                            plantFeature: _plantList[widget.plantId].size,
                          ),
                          PlantFeature(
                            title: 'Humidity',
                            plantFeature:
                                _plantList[widget.plantId].humidity.toString(),
                          ),
                          PlantFeature(
                            title: 'Temperature',
                            plantFeature:
                                _plantList[widget.plantId].temperature,
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
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _plantList[widget.plantId].plantName,
                            style: TextStyle(
                              color: BgTumbuhan.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            r'$' + _plantList[widget.plantId].price.toString(),
                            style: TextStyle(
                              color: BgTumbuhan.blackColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _plantList[widget.plantId].rating.toString(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: BgTumbuhan.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 30.0,
                            color: BgTumbuhan.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      _plantList[widget.plantId]
                          .decription, // Perbaikan: description
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: BgTumbuhan.blackColor.withOpacity(.7),
                      ),
                    ),
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
                onPressed: () {
                  setState(() {
                    bool isSelected =
                        toggleIsSelected(_plantList[widget.plantId].isSelected);
                    _plantList[widget.plantId].isSelected = isSelected;

                    if (isSelected) {
                      _controller.myCart.add(_plantList[widget.plantId]);
                    } else {
                      _controller.myCart.remove(_plantList[widget.plantId]);
                    }
                  });
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: _plantList[widget.plantId].isSelected == true
                      ? Colors.white
                      : BgTumbuhan.primaryColor,
                ),
              ),
              decoration: BoxDecoration(
                color: _plantList[widget.plantId].isSelected == true
                    ? BgTumbuhan.primaryColor.withOpacity(.5)
                    : Colors.white,
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
                  Get.to(
                    CheckoutPembelian(
                      addedToCartPlants: [],
                    ),
                    transition: Transition.downToUp,
                  );
                  // Handle action when Buy Now button is tapped
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: BgTumbuhan.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: BgTumbuhan.primaryColor.withOpacity(.3),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
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

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: BgTumbuhan.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: BgTumbuhan.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
