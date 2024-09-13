// To parse this JSON data, do
//
//     final bannerImage = bannerImageFromJson(jsonString);

import 'dart:convert';

import 'package:money2me/common/response_model.dart';

ListResponse<BannerImage> bannerImageFromJson(Map<String,dynamic> data) => ListResponse.fromJson(data, (data) => List<BannerImage>.from(data.map((e) => BannerImage.fromJson(e))));

String bannerImageToJson(BannerImage data) => json.encode(data.toJson());

class BannerImage extends Serializable{
  String? title;
  String? imageUrl;

  BannerImage({
    this.title,
    this.imageUrl,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
    title: json["Title"],
    imageUrl: json["ImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "ImageURL": imageUrl,
  };
}
