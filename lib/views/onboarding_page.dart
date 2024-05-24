import 'package:flutter/material.dart';
import 'package:Florist/app_styles.dart'; // Import gaya aplikasi
import 'package:Florist/main.dart'; // Import file main.dart
import 'package:Florist/model/onboard_data.dart'; // Import data onboarding
import 'package:Florist/size_configs.dart'; // Import konfigurasi ukuran
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import './pages.dart'; // Import halaman lain
import '../widgets/widgets.dart'; // Import widget lainnya

// Kelas OnboardingPage merupakan StatefulWidget yang menampilkan halaman onboarding aplikasi
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage =
      10; // Indeks halaman saat ini, diinisialisasi dengan nilai default
  PageController _pageController =
      PageController(initialPage: 0); // Controller untuk PageView

  // Metode untuk membuat indikator titik yang beranimasi
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  // Metode untuk mengatur SharedPreferences saat halaman onboarding pertama kali dimuat
  Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
    // Ini akan mengatur seenOboard ke true saat halaman onboarding dijalankan untuk pertama kalinya.
  }

  // Metode initState akan dipanggil saat widget diinisialisasi
  @override
  void initState() {
    super.initState();
    setSeenOnboard(); // Panggil metode setSeenOnboard untuk mengatur SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // Inisialisasi konfigurasi ukuran
    double sizeV = SizeConfig.blockSizeV!; // Mendapatkan ukuran blok vertikal

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage =
                        value; // Perbarui nilai currentPage saat halaman berubah
                  });
                },
                itemCount:
                    onboardingContents.length, // Jumlah halaman onboarding
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(height: sizeV * 5),
                    Text(
                      onboardingContents[index]
                          .title, // Judul halaman onboarding
                      style: kTitle, // Gunakan gaya teks kTitle
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sizeV * 5),
                    Container(
                      height: sizeV * 50,
                      child: Image.asset(
                        onboardingContents[index]
                            .image, // Gambar halaman onboarding
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: sizeV * 5),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: kBodyText1, // Gunakan gaya teks kBodyText1
                        children: [
                          TextSpan(text: 'WE CAN '),
                          TextSpan(
                            text: 'HELP YOU ',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          TextSpan(text: 'TO BE A BETTER '),
                          TextSpan(text: 'VERSION OF '),
                          TextSpan(
                            text: 'YOURSELF ',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeV * 5),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  currentPage == onboardingContents.length - 1
                      ? MyTextButton(
                          buttomName: 'Get Started',
                          onPressed: () {
                            Get.off(
                              Login(),
                            ); // Pindahkan ke halaman login
                          },
                          bgColor: BgTumbuhan.primaryColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnBoardNavBtn(
                              name: 'Skip',
                              onPressed: () {
                                Get.off(
                                  Login(),
                                ); // Pindahkan ke halaman login
                              },
                            ),
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                            OnBoardNavBtn(
                              name: 'Next',
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                              },
                            )
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
