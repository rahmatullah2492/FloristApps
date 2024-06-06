const baseUrl = "http://192.168.1.3:80/api"; // wifi rumah
// const baseUrl = "http://192.168.43.192:80/api"; // WIFI Kampus

// url
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/register';
const logoutUrl = '$baseUrl/logout';
const userUrl = '$baseUrl/user';
const detailUserUrl = '$baseUrl/detail_users';
const pesananUrl = '$baseUrl/pesanans';
const detailPesananUrl = '$baseUrl/detail_pesanan';
const tanamanUrl = '$baseUrl/tanaman';
const keranjangUrl = '$baseUrl/keranjang';

// unggah fotoProfile
const uploadProfileUrl = '$baseUrl/upload_profile';
const getProfileUrl = '$baseUrl/get_profile';

// error
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again later';
