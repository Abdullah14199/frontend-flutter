import 'dart:io';

class userProfileModel {
  final File image;
  const userProfileModel(
      {
        required this.image,
      });
  factory userProfileModel.fromJson(Map< String ,dynamic >json){
    return userProfileModel(
      image: json['selfie'],
    );
  }

  Map<String, File> toJson() => {
    "selfie" : image,
  };
}