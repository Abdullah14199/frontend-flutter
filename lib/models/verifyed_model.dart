class VerifyedModel {
  bool? burgerMenuValid;
  bool? has_AOF;
  int? notificationsCount;
  String? hasRating;

  VerifyedModel(
      {this.burgerMenuValid,
      this.has_AOF,
      this.hasRating,
      this.notificationsCount});

  VerifyedModel.fromJson(Map<String, dynamic> json) {
    burgerMenuValid = json['BurgerMenuValid'];
    has_AOF = json['Has_AOF'];
    notificationsCount = json['NotificationsCount'];
    // hasRating = json['hasRating']==null?null:json["hasRating"];
  }

  Map<String, dynamic> toJson() {
    return {
      'BurgerMenuValid': burgerMenuValid,
      'Has_AOF': has_AOF,
      'NotificationsCount': notificationsCount
    };
  }
}
