class EmailVerified{
  String ? message ;


  EmailVerified(
      {
        this.message
      });

  EmailVerified.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

}

