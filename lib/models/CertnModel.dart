class CertnModel {
  final String id , redirect_url ;
  const CertnModel(
      {
        required this.id,
        required this.redirect_url,
      });
  factory CertnModel.fromJson(Map< String ,dynamic >json){
    return CertnModel(
      id: json['id'],
      redirect_url: json['redirect_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "redirect_url" : redirect_url,
  };
}