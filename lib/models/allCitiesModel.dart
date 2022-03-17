class AllCitys {
  AllCitys({
    required this.id,
    required this.regionId,
    required this.regionName,
    required this.regionLatLng,
    required this.centerPositions,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.Selected,
  });
  late final int id;
  late final String regionId;
  late final String regionName;
  late final List<RegionLatLng> regionLatLng;
  late final CenterPositions centerPositions;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final bool Selected;

  AllCitys.fromJson(Map<String, dynamic> json){
    id = json['id'];
    regionId = json['region_id'];
    regionName = json['region_name'];
    regionLatLng = List.from(json['region_lat_lng']).map((e)=>RegionLatLng.fromJson(e)).toList();
    centerPositions = CenterPositions.fromJson(json['center_positions']);
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    Selected = json['Selected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['region_id'] = regionId;
    _data['region_name'] = regionName;
    _data['region_lat_lng'] = regionLatLng.map((e)=>e.toJson()).toList();
    _data['center_positions'] = centerPositions.toJson();
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['Selected'] = Selected;
    return _data;
  }
}

class RegionLatLng {
  RegionLatLng({
    required this.lat,
    required this.lng,
  });
  late final String lat;
  late final String lng;

  RegionLatLng.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class CenterPositions {
  CenterPositions({
    required this.lat,
    required this.lng,
  });
  late final String lat;
  late final String lng;

  CenterPositions.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}