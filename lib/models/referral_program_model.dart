class refalProgramModel {
  final String ReferralCode ;
  final int ReferralBalance;
  const refalProgramModel(
      {
        required this.ReferralCode,
        required this.ReferralBalance,

      });
  factory refalProgramModel.fromJson(Map< String ,dynamic >json){
    return refalProgramModel(
      ReferralCode: json['ReferralCode'],
      ReferralBalance: json['ReferralBalance']==null? 0 :json["ReferralBalance"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ReferralCode" : ReferralCode,
    "ReferralBalance" : ReferralBalance,
  };
}