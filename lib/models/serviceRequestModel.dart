import 'package:http/http.dart' as http;

class ServiceRequestModel{
  final int type;
  final bool visiable;

  const ServiceRequestModel({required this.type , required this.visiable});

  factory ServiceRequestModel.fromJson(Map<String , dynamic> json){
    return ServiceRequestModel(
      type: json['type'],
      visiable: json['Visable'],
    );
  }

  Map<String, dynamic> toJson() => {
    "type" : type,
    "Visable" : visiable,

  };
}