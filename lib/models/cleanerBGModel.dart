import 'package:http/http.dart' as http;

class CallApiBG{
  final String gender;
  final String country_inti;


  const CallApiBG({required this.gender , required this.country_inti});

  factory CallApiBG.fromJson(Map<String , dynamic> json){
    return CallApiBG(
      gender: json['gender'],
      country_inti: json['country_inti'],
    );
  }

  Map<String, dynamic> toJson() => {
    "gender" : gender,
    "country_inti" : country_inti,
  };
}