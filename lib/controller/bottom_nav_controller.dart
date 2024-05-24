import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/list_tumbuhan.dart';
import '../views/pages.dart';

class BottomNavBarController extends GetxController {
  RxInt index = 0.obs;

  RxList<Plant> favorites =
      <Plant>[].obs; // RxList untuk mengelola daftar favorit
  RxList<Plant> myCart =
      <Plant>[].obs; // RxList untuk mengelola daftar item di keranjang belanja

  @override
  void onInit() {
    super.onInit();

    // Inisialisasi daftar favorit dan daftar item di keranjang belanja
    final Set<Plant> favoritedPlantsSet = Plant.getFavoritedPlants().toSet();
    final List<Plant> addedToCartPlants =
        Plant.addedToCartPlants().toSet().toList();

    // Menetapkan daftar favorit dan daftar item di keranjang belanja ke RxList
    favorites.assignAll(favoritedPlantsSet);
    myCart.assignAll(addedToCartPlants);
  }

  List<Widget> widgetOptions() {
    return [
      const HomePage(),
      ProdukPage(),
      FavoritePage(
          favoritedPlants: favorites), // Perbarui penyediaan daftar favorit
      KeranjangPage(
          addedToCartPlants:
              myCart), // Perbarui penyediaan daftar item di keranjang belanja
      ProfilePage(),
    ];
  }

  List<Widget> get pages => widgetOptions();

  void addToFavorites(Plant plant) {}

  void removeFromFavorites(Plant plant) {} // Perlu diubah menjadi getter
}
