//dartz, bisa load data dari 2 resource
import 'package:dartz/dartz.dart';
import 'package:fic_ecommerce_tv/common/global_variable.dart';
import 'package:fic_ecommerce_tv/data/models/responses/list_product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  //future karena nunggu dulu dari internet, either karena
  //utk menampilkan kesalahan
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response =
        await http.get(Uri.parse("${GlobalVariables.baseUrl}/products"));

    //right left dari dartz
    if (response.statusCode == 200) {
      //rightnya diisi oleh list product model
      return Right(
          //pakainya yang fromrawjson
          ListProductResponseModel.fromRawJson(response.body));
    } else {
      //leftnya diisi oleh list product model
      return const Left("Proses anda gagal");
    }
  }
}
