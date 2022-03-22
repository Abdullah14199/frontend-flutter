class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? dateOfBirth;
  String? lat;
  String? lng;
  String? fcmToken;
  String? firebaseUid;
  String? deviceId;
  Null? registrationType;
  String? userType;
  bool? isVerfied;
  String? selfie;
  String? gender;
  String? countryInti;
  int? status;
  bool? hasPlaces;
  String? rate;
  String? criminalFree;
  String? createdAt;
  String? updatedAt;
  bool? emailVerified;
  Null? cleanerCity;
  Null? address;
  bool? certnWizerd;
  String? level;
  String? levelStatus;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.countryCode,
        this.dateOfBirth,
        this.lat,
        this.lng,
        this.fcmToken,
        this.firebaseUid,
        this.deviceId,
        this.registrationType,
        this.userType,
        this.isVerfied,
        this.selfie,
        this.gender,
        this.countryInti,
        this.status,
        this.hasPlaces,
        this.rate,
        this.criminalFree,
        this.createdAt,
        this.updatedAt,
        this.emailVerified,
        this.cleanerCity,
        this.address,
        this.certnWizerd,
        this.level,
        this.levelStatus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    dateOfBirth = json['date_of_birth'];
    lat = json['lat'];
    lng = json['lng'];
    fcmToken = json['fcm_token'];
    firebaseUid = json['firebase_uid'];
    deviceId = json['device_id'];
    registrationType = json['registration_type'];
    userType = json['user_type'];
    isVerfied = json['is_verfied'];
    selfie = json['selfie'];
    gender = json['gender'];
    countryInti = json['country_inti'];
    status = json['status'];
    hasPlaces = json['has_places'];
    rate = json['rate'];
    criminalFree = json['criminal_free'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerified = json['email_verified'];
    cleanerCity = json['cleaner_city'];
    address = json['address'];
    certnWizerd = json['certn_wizerd'];
    level = json['level'];
    levelStatus = json['level_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['date_of_birth'] = this.dateOfBirth;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['fcm_token'] = this.fcmToken;
    data['firebase_uid'] = this.firebaseUid;
    data['device_id'] = this.deviceId;
    data['registration_type'] = this.registrationType;
    data['user_type'] = this.userType;
    data['is_verfied'] = this.isVerfied;
    data['selfie'] = this.selfie;
    data['gender'] = this.gender;
    data['country_inti'] = this.countryInti;
    data['status'] = this.status;
    data['has_places'] = this.hasPlaces;
    data['rate'] = this.rate;
    data['criminal_free'] = this.criminalFree;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['email_verified'] = this.emailVerified;
    data['cleaner_city'] = this.cleanerCity;
    data['address'] = this.address;
    data['certn_wizerd'] = this.certnWizerd;
    data['level'] = this.level;
    data['level_status'] = this.levelStatus;
    return data;
  }
}