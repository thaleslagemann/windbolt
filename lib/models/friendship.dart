class Friendship {
  final String userUuid;
  final DateTime initDate;

  Friendship({required this.userUuid, DateTime? initDate}) : initDate = initDate ?? DateTime.now();

  Map<String, String?> toMap() {
    return {
      'userUuid': userUuid.toString(),
      'initDate': initDate.toString(),
    };
  }

  factory Friendship.fromMap(Map<String, dynamic> map) {
    return Friendship(
      userUuid: map['userUuid'].toString(),
      initDate: DateTime.parse(map['initDate']),
    );
  }
}
