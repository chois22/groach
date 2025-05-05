// 상태를 나타날 때 status
enum StatusOfPw { none, match, not_match, Invalid_Pw }

enum ProgramType { recommend, popular, hot, brand_new, staycation, rural, up }

enum ServiceType { wifi, pet, parking }

enum ReviewKeyWord {
  good_facility, // 시설이 잘 관리되어 있어요
  kind_owner, // 사장님이 친절해요
  luxury_facility, // 시설물이 력셔리해요
  good_view, // 뷰가 좋아요
  with_couple, // 연인과 함께 가기 좋아요
}

enum SignUpMessage {
  Empty_Email,
  Duplicate_Email,
  Invalid_Email,
  Possible_Email,

  Empty_Name,
  Invalid_Name,

  Empty_NickName,
  Duplicate_NickName,
  Invalid_NickName,
  Possible_NickName,

  Empty_Pw,
  Invalid_Pw,
  Possible_Pw,

}