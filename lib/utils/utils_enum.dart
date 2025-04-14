import 'package:practice1/const/value/enum.dart';

class UtilsEnum {
  /// ServiceType 한글 받아오기
  static String getNameFromServiceType(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.wifi:
        return '와이파이';
      case ServiceType.pet:
        return '반려동물';
      case ServiceType.parking:
        return '주차';
    }
  }

  /// ServiceType 한글 받아오기
  static String getImgUrlFromServiceType(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.wifi:
        return 'assets/icon/wifi_icon.png';
      case ServiceType.pet:
        return 'assets/icon/pet_icon.png';
      case ServiceType.parking:
        return 'assets/icon/parking_icon.png';
    }
  }


}
