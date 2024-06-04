import 'package:Florist/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  late BottomNavBarController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomNavBarController()); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xff296e48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Obx(
            () => GNav(
              backgroundColor: Color(0xff296e48),
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor:
                  Color.fromARGB(255, 29, 77, 51).withOpacity(0.55),
              gap: 8,
              padding: EdgeInsets.all(10),
              onTabChange: (value) {
                print(value);
                controller.index.value = value;
              },
              selectedIndex: controller.index
                  .value, // Set selectedIndex to the value from controller
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.shopify_rounded,
                  text: 'Produk Baru',
                ),
                // GButton(
                //   icon: Icons.favorite_border,
                //   text: 'Favorite',
                // ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Keranjang',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.pages[controller.index.value],
      ),
    );
  }
}
