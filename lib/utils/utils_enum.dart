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

  /// 프로그램 타입 한글 받아오기
  static String getNameFromProgramType(ProgramType programType) {
    switch (programType) {
      case ProgramType.recommend:
        return '추천 프로그램';
      case ProgramType.popular:
        return '인기 프로그램';
      case ProgramType.hot:
        return '급상승 프로그램';
      case ProgramType.brand_new:
        return '신규 프로그램';
      case ProgramType.staycation:
        return '호캉스 프로그램';
      case ProgramType.rural:
        return '농촌한달살기 프로그램';
      case ProgramType.up:
        return 'up 프로그램';
      case ProgramType.similar:
        return '비슷한 프로그램';
    }
  }

  /// 프로그램들 아이콘
  static String getImgUrlFromProgramIcon(ProgramType programType) {
    switch (programType) {
      case ProgramType.recommend:
        return 'assets/icon/sparkles.png';
      case ProgramType.popular:
        return 'assets/icon/hot_icon.svg';
      case ProgramType.hot:
        return 'assets/icon/up_icon.svg';
      case ProgramType.brand_new:
        return 'assets/icon/new_icon.svg';
      case ProgramType.staycation:
        return '';
      case ProgramType.rural:
        return '';
      case ProgramType.up:
        return '';
      case ProgramType.similar:
        return '';
    }
  }

  /// ServiceType 아이콘 받아오기
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
  /// 리뷰 키워드 한글 받아오기
  static String getNameFromReviewKeyWord(ReviewKeyWord reviewKeyWord) {
    switch (reviewKeyWord) {
      case ReviewKeyWord.good_facility:
        return '시설이 잘 관리되어 있어요';
      case ReviewKeyWord.kind_owner:
        return '사장님이 친절해요';
      case ReviewKeyWord.luxury_facility:
        return '시설물이 력셔리해요';
      case ReviewKeyWord.good_view:
        return '뷰가 좋아요';
      case ReviewKeyWord.with_couple:
        return '연인과 함께 가기 좋아요';
    }
  }

  /// 리뷰 키워드 아이콘 받아오기
  static String getNameFromReviewKeyWordIcon(ReviewKeyWord reviewKeyWord) {
    switch (reviewKeyWord) {
      case ReviewKeyWord.good_facility:
        return 'assets/icon/review_smile_icon.svg';
      case ReviewKeyWord.kind_owner:
        return 'assets/icon/review_thumb_icon.svg';
      case ReviewKeyWord.luxury_facility:
        return 'assets/icon/review_diamond_icon.svg';
      case ReviewKeyWord.good_view:
        return 'assets/icon/review_mountain_icon.svg';
      case ReviewKeyWord.with_couple:
        return 'assets/icon/review_heart_icon.svg';
    }
  }

  /// 회원가입 메세지들
  static String getSignUpMessage(SignUpMessage signUpMessage) {
    switch (signUpMessage) {
      case SignUpMessage.Empty_Email:
        return '이메일을 입력해주세요.';
      case SignUpMessage.Duplicate_Email:
        return '사용중인 이메일입니다.';
      case SignUpMessage.Invalid_Email:
        return '잘못된 이메일 형식입니다.';
      case SignUpMessage.Possible_Email:
        return '사용 가능한 이메일입니다.';

      case SignUpMessage.Empty_Name:
        return '이름을 입력해주세요.';
      case SignUpMessage.Invalid_Name:
        return '이름은 한글로 입력해주세요.';

      case SignUpMessage.Empty_NickName:
        return '닉네임을 입력해주세요.';
      case SignUpMessage.Duplicate_NickName:
        return '사용중인 닉네임입니다.';
      case SignUpMessage.Invalid_NickName:
        return '특수문자는 사용할 수 없습니다.';
      case SignUpMessage.Possible_NickName:
        return '사용 가능한 닉네임입니다.';

      case SignUpMessage.Empty_Pw:
        return '비밀번호를 입력해주세요.';
      case SignUpMessage.Invalid_Pw:
        return '잘못된 비밀번호 형식입니다.';
      case SignUpMessage.Possible_Pw:
        return '사용 가능한 비밀번호입니다.';
    }
  }
}


