class CertnVerifyedModel {
  int ? selfie;
  int ? government;
  bool ? email;
  String ? certin_status;
  bool ? Sterling;

  CertnVerifyedModel(
      {
        this.certin_status,this.email,this.selfie,this.government,this.Sterling
      });


  CertnVerifyedModel.fromJson(Map<String, dynamic> json) {
    selfie = json['Selfie'];
    government = json['Government'];
    email = json['email'];
    certin_status = json['certin_status'];
    Sterling = json['Sterling'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Selfie': selfie,
      'Government': government,
      'email': email,
      'certin_status': certin_status,
      'Sterling': Sterling
    };
  }


}

