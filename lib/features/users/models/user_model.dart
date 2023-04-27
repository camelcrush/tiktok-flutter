class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String link;
  final String birthday;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.link,
    required this.birthday,
    required this.hasAvatar,
  });

  // User SignUp일 경우 Profile을 새로 생성하려면 State값을 빈 값으로 우선 초기화하기 위함
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        birthday = "",
        hasAvatar = false;

  // Backend로부터 받은 Json데이터를 flutter Model로 전환하기 위한 constructor
  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        bio = json['bio'],
        link = json['link'],
        birthday = json['birthday'],
        hasAvatar = json['hasAvatar'] ?? false;

// Firestroe는 JSON을 받기 때문에
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "birthday": birthday,
    };
  }

// 'copyWith'는 Flutter에서 사용하는 메소드 중 하나로, 기존 객체를 복제하고 일부 속성을 수정하여 새로운 객체를 생성하는 기능을 합니다.
// 일반적으로 객체의 속성을 변경할 때, 해당 객체를 직접 수정하는 방식으로 처리할 수 있습니다.
// 그러나, 이 방식은 객체의 불변성(immutability)을 보장하지 않기 때문에 예상치 못한 결과를 초래할 수 있습니다.
// 'copyWith'는 이러한 문제를 해결하기 위한 방법으로, 불변성을 보장하면서 객체의 일부 속성을 변경할 수 있도록 해줍니다.
// 이는 객체 지향 프로그래밍에서 매우 중요한 개념 중 하나로, 객체의 불변성을 유지하면서 객체를 다루는 것이 코드의 안정성과 가독성을 향상시키는 데 도움이 됩니다.
  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
