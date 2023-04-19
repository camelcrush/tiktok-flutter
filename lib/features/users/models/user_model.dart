class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
  });

  // User SignUp일 경우 Profile을 새로 생성하려면 State값을 빈 값으로 우선 초기화하기 위함
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "";

// Firestroe는 JSON을 받기 때문에
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
    };
  }
}
