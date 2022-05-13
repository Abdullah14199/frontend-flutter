import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skep_home_pro/constatns/constants.dart';
import 'package:skep_home_pro/controllers/AreaOfWorkController.dart';

class GoogleMapViewModel extends GetxController {
  final areaOfWorkCon = Get.put(AreaOfWorkController());

  GoogleMapViewModel() {
    chickbox();
    myPolygon();
  }

  final eto = GetStorage();
  RxBool Etobicoke = false.obs;
  RxBool Mississauga = false.obs;
  RxBool Toronto = false.obs;
  RxBool ready = false.obs;
  List isLoad = [];
  int count = 0;
  var polygonCoords = <LatLng>[];

  void chickbox() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Etobicoke = pref.get('Eto').obs as RxBool;
    Mississauga = pref.get('Mis').obs as RxBool;
    Toronto = pref.get('Tor').obs as RxBool;
    print(Etobicoke);
  }

  Set<Polygon> myPolygon() {
    ready = false.obs;
    polygonCoords = [];
    if (eto.read('eto')) {
      // var lat;
      // var lng;
      // for (int d = 0; d <= areaOfWorkCon.allCity[0].regionLatLng.length; d++) {
      //   lat = double.parse(areaOfWorkCon.allCity[0].regionLatLng[d].lat);
      //   lng = double.parse(areaOfWorkCon.allCity[0].regionLatLng[d].lng);
      //   polygonCoords.add(LatLng(lat, lng));
      // }


      polygonCoords.add(LatLng(43.58212474050701, -79.53552631883628));
      polygonCoords.add(LatLng(43.748906981940614, -79.63268496213254));
      polygonCoords.add(LatLng(43.75999437671437, -79.58340124914241));
      polygonCoords.add(LatLng(43.73997835878101, -79.55848538716515));
      polygonCoords.add(LatLng(43.74307884733433, -79.54337918599327));
      polygonCoords.add(LatLng(43.68471379096746, -79.50960394822533));
      polygonCoords.add(LatLng(43.65215651864313, -79.49408962035699));
      polygonCoords.add(LatLng(43.629274011989786, -79.46449905957849));
      polygonCoords.add(LatLng(43.60460309602409, -79.48433488332194));
      polygonCoords.add(LatLng(43.58464731765196, -79.51035051663564));
      polygonCoords.add(LatLng(43.58216038518011, -79.52785997708486));


    } else {
      polygonCoords.add(const LatLng(43.58212474050701, -79.53552631883628));
    }

    if (Mississauga.value) {
      // var lat;
      // var lng;
      // for (int d = 0; d < areaOfWorkCon.allCity[1].regionLatLng.length; d++) {
      //   lat = double.parse(areaOfWorkCon.allCity[1].regionLatLng[d].lat);
      //   lng = double.parse(areaOfWorkCon.allCity[1].regionLatLng[d].lng);
      //   polygonCoords.add(LatLng(lat, lng));
      // }

      polygonCoords.add(LatLng(43.586217611693705, -79.5395530164152));
      polygonCoords.add(LatLng(43.75015056752378, -79.63388984281067));
      polygonCoords.add(LatLng(43.72665805150493, -79.66956788086492));
      polygonCoords.add(LatLng(43.70180115858123, -79.67738584690522));
      polygonCoords.add(LatLng(43.6771822615572, -79.69035365425412));
      polygonCoords.add(LatLng(43.638788318639904, -79.72642722284343));
      polygonCoords.add(LatLng(43.58520190298336, -79.80026629436242));
      polygonCoords.add(LatLng(43.51204387354191, -79.68902972209679));
      polygonCoords.add(LatLng(43.520757818895895, -79.67941668498742));
      polygonCoords.add(LatLng(43.47941765205318, -79.62276843059288));
      polygonCoords.add(LatLng(43.58129118317812, -79.53821663079941));

    } else {
      polygonCoords.add(const LatLng(43.58212474050701, -79.53552631883628));
    }
    if (Toronto.value) {
      // var lat;
      // var lng;
      // for (int d = 0; d < 6; d++) {
      //   lat = double.parse(areaOfWorkCon.allCity[2].regionLatLng[d].lat);
      //   lng = double.parse(areaOfWorkCon.allCity[2].regionLatLng[d].lng);
      //   polygonCoords.add(LatLng(lat, lng));
      // }

      polygonCoords.add(LatLng(43.66503794707735, -79.50012122667005));
      polygonCoords.add(LatLng(43.682903598226495, -79.41826845093715));
      polygonCoords.add(LatLng(43.682422550238854, -79.41803241654384));
      polygonCoords.add(LatLng(43.70829150520779, -79.29466009140015));
      polygonCoords.add(LatLng(43.67172445757437, -79.27889735548735));
      polygonCoords.add(LatLng(43.631821892719294, -79.38277888902871));



    } else {
      polygonCoords.add(LatLng(43.58212474050701, -79.53552631883628));
    }
    var polygonSet = Set<Polygon>();
    polygonSet.add(Polygon(
        fillColor: constants.grey,
        visible: true,
        polygonId: PolygonId('1'),
        points: polygonCoords,
        strokeWidth: 3,
        strokeColor: constants.blue2));
    ready = true.obs;
    return polygonSet;
  }
}
