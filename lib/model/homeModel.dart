import 'package:luna/model/soundsModel.dart';

class HomeModel {
  final String heading;
  final List<SoundsModel> soundsModel;

  const HomeModel({
    required this.soundsModel,
    required this.heading,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      heading: json["heading"],
      soundsModel: json["sounds"]
          .map<SoundsModel>((json) => SoundsModel.fromJson(json))
          .toList(),
    );
  }
}
