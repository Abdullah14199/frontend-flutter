class InformationUser {
  InformationUser({
    required this.requestEnhancedCriminalRecordCheck,
    required this.requestEnhancedIdentityVerification,
    required this.email,
    required this.information,
  });
  late final bool requestEnhancedCriminalRecordCheck;
  late final bool requestEnhancedIdentityVerification;
  late final String email;
  late final Information information;

  InformationUser.fromJson(Map<String, dynamic> json){
    requestEnhancedCriminalRecordCheck = json['request_enhanced_criminal_record_check'];
    requestEnhancedIdentityVerification = json['request_enhanced_identity_verification'];
    email = json['email'];
    information = Information.fromJson(json['information']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['request_enhanced_criminal_record_check'] = requestEnhancedCriminalRecordCheck;
    _data['request_enhanced_identity_verification'] = requestEnhancedIdentityVerification;
    _data['email'] = email;
    _data['information'] = information.toJson();
    return _data;
  }
}

class Information {
  Information({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.birthCity,
    required this.birthProvinceState,
    required this.birthCountry,
    required this.gender,
    required this.phoneNumber,
    required this.addresses,
    required this.convictions,
    required this.rcmpConsentGiven,
  });
  late final String firstName;
  late final String lastName;
  late final String dateOfBirth;
  late final String birthCity;
  late final String birthProvinceState;
  late final String birthCountry;
  late final String gender;
  late final String phoneNumber;
  late final List<Addresses> addresses;
  late final List<Convictions> convictions;
  late final bool rcmpConsentGiven;

  Information.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    birthCity = json['birth_city'];
    birthProvinceState = json['birth_province_state'];
    birthCountry = json['birth_country'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    addresses = List.from(json['addresses']).map((e)=>Addresses.fromJson(e)).toList();
    convictions = List.from(json['convictions']).map((e)=>Convictions.fromJson(e)).toList();
    rcmpConsentGiven = json['rcmp_consent_given'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['date_of_birth'] = dateOfBirth;
    _data['birth_city'] = birthCity;
    _data['birth_province_state'] = birthProvinceState;
    _data['birth_country'] = birthCountry;
    _data['gender'] = gender;
    _data['phone_number'] = phoneNumber;
    _data['addresses'] = addresses.map((e)=>e.toJson()).toList();
    _data['convictions'] = convictions.map((e)=>e.toJson()).toList();
    _data['rcmp_consent_given'] = rcmpConsentGiven;
    return _data;
  }
}

class Addresses {
  Addresses({
    required this.address,
    required this.city,
    required this.provinceState,
    required this.country,
  });
  late final String address;
  late final String city;
  late final String provinceState;
  late final String country;

  Addresses.fromJson(Map<String, dynamic> json){
    address = json['address'];
    city = json['city'];
    provinceState = json['province_state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['city'] = city;
    _data['province_state'] = provinceState;
    _data['country'] = country;
    return _data;
  }
}

class Convictions {
  Convictions({
    required this.offense,
    required this.dateOfSentence,
    required this.courtLocation,
    required this.description,
  });
  late final String offense;
  late final String dateOfSentence;
  late final String courtLocation;
  late final String description;

  Convictions.fromJson(Map<String, dynamic> json){
    offense = json['offense'];
    dateOfSentence = json['date_of_sentence'];
    courtLocation = json['court_location'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['offense'] = offense;
    _data['date_of_sentence'] = dateOfSentence;
    _data['court_location'] = courtLocation;
    _data['description'] = description;
    return _data;
  }
}