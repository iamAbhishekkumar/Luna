class SoundsModel {
  final String name;
  final String artist;
  final String soundUrl;
  final String imageUrl;
  final String duration;

  SoundsModel({
    required this.name,
    required this.artist,
    required this.soundUrl,
    required this.imageUrl,
    required this.duration,
  });

  factory SoundsModel.fromJson(Map<String, dynamic> json) {
    return SoundsModel(
      name: json["name"],
      artist: json["artist"],
      soundUrl: json["sound"],
      imageUrl: json["image"],
      duration: json["duration"],
    );
  }
}
