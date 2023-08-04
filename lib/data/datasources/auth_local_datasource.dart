import 'package:fic_ecommerce_tv/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthLocalDataSource {
  //save auth ketika menyimpan tokennya

  Future<bool> saveAuthData(AuthResponseModel model) async {
    //inisiasi shared preferences dulu
    final SharedPreferences pref = await SharedPreferences.getInstance();

    //menyimpan data user yang login ke auth
    final result = await pref.setString('auth', jsonEncode(model.toJson()));

    return result;
  }

  Future<bool> removeAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    return await pref.remove('auth'); //kembalikan authnya
  }

  //Future async await (menunggu datanya dulu)
  Future<String> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? ''; //belum tentu ada
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));

    return authData.jwt; //ambil token jwt (json web token) nya
  }

  //returnnya berupa model
  Future<AuthResponseModel> getAuthData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    //ambil data dari auth
    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));

    return authData;
  }

  //mendapatkan data user
  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final authJson = pref.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));

    return authData.user; //menampilkan data user
  }

  //yang dambil user idnya aja
  Future<int> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final authJson = pref.getString('auth') ?? '';

    final authData = AuthResponseModel.fromJson(jsonDecode(authJson));

    return authData.user.id;
  }

  Future<bool> isLogin() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final authJson = pref.getString('auth');

    return authJson != null; //kalau jsonnya tidak kosong
  }
}
