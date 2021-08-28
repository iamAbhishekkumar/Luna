import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:luna/model/homeModel.dart';
import 'package:luna/model/soundsModel.dart';

class Repository {
  Future<List<HomeModel>> getHomeContent() async {
    List<HomeModel> _homeModels = [];
    try {
      Uri url = Uri.parse(
          'https://luna-50a55-default-rtdb.firebaseio.com/content.json');
      http.Client client = http.Client();
      http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        _homeModels =
            parsed.map<HomeModel>((json) => HomeModel.fromJson(json)).toList();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return _homeModels;
  }

  Future<List<SoundsModel>> getAllSongs() async {
    List<SoundsModel> _allSounds = [];
    try {
      Uri url = Uri.parse(
          'https://luna-50a55-default-rtdb.firebaseio.com/all_sounds.json');
      http.Client client = http.Client();
      http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        _allSounds = parsed
            .map<SoundsModel>((json) => SoundsModel.fromJson(json))
            .toList();
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return _allSounds;
  }
}
