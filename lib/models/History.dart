class History{
  final String oldLocation;
  final String newLocation;
  final String dateTime;
  final String movedBy;

  History({
    required this.oldLocation,
    required this.newLocation,
    required this.dateTime,
    required this.movedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldLocation": oldLocation,
      "newLocation": newLocation,
      "dateTime": dateTime,
      "movedBy": movedBy,
    };
  }

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      oldLocation: json["oldLocation"],
      newLocation: json["newLocation"],
      dateTime: json["dateTime"],
      movedBy: json["movedBy"],
    );
  }
}
