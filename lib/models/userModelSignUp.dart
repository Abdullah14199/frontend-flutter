import 'package:http/http.dart' as http;

class CallApi{
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final String lat , lng ;

  const CallApi({required this.first_name , required this.last_name , required this.email , required this.phone , required this.lat , required this.lng });

  factory CallApi.fromJson(Map<String , dynamic> json){
    return CallApi(
        first_name: json['first_name'],
        last_name: json['last_name'],
        email: json['email'],
        phone: json['phone'],
        lat: json['lat'],
        lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() => {
    "email" : email,
    "first_name" : first_name,
    "last_name" : last_name,
    "phone" : phone,
    "lat" : lat,
    "lng" : lng,
  };
}