import 'package:Florist/constant.dart';
import 'package:http/http.dart' as http;
import 'package:Florist/model/pesanan/api_response_pesanan.dart';

Future<ApiResponsePesanan> getPesanan() async {
  ApiResponsePesanan apiResponse = ApiResponsePesanan();
  try {
    final response = await http.get(Uri.parse(pesananUrl));
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.message = 'Pesanan fetched successfully';
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponsePesanan> postPesanan() async {
  ApiResponsePesanan apiResponse = ApiResponsePesanan();
  try {
    final response = await http.post(Uri.parse(pesananUrl));
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.message = 'Pesanan created successfully';
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
