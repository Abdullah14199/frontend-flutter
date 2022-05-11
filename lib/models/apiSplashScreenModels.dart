class userModelSplash {
  final String address , email , first_name , last_name , user_type;
  const userModelSplash(
      {
        required this.address,
        required this.email,
        required this.first_name,
        required this.last_name,
        required this.user_type
      });
  factory userModelSplash.fromJson(Map< String ,dynamic >json){
    return userModelSplash(
        address: json['address']==null?"":json["address"],
        email: json['email'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        user_type: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() => {
    "address" : address,
    "email" : email,
    "first_name" : first_name,
    "last_name" : last_name,
    "user_type" : user_type,
  };
}