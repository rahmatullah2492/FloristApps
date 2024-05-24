class OnBoarding {
  final String title; // Properti untuk menyimpan judul halaman onboarding
  final String
      image; // Properti untuk menyimpan lokasi gambar halaman onboarding

  // Konstruktor kelas OnBoarding
  OnBoarding({
    required this.title, // Inisialisasi properti judul
    required this.image, // Inisialisasi properti gambar
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: 'Welcome to\n Monumental habits', // Judul untuk halaman pertama
    image:
        'assets/images/onboarding_image_1.png', // Lokasi gambar untuk halaman pertama
  ),
  OnBoarding(
    title: 'Create new habits easily', // Judul untuk halaman kedua
    image:
        'assets/images/onboarding_image_2.png', // Lokasi gambar untuk halaman kedua
  ),
  OnBoarding(
    title: 'Keep track of your progress', // Judul untuk halaman ketiga
    image:
        'assets/images/onboarding_image_3.png', // Lokasi gambar untuk halaman ketiga
  ),
  OnBoarding(
    title: 'Join a supportive community', // Judul untuk halaman keempat
    image:
        'assets/images/onboarding_image_4.png', // Lokasi gambar untuk halaman keempat
  ),
];
