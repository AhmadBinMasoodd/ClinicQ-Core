class History {
  final String oldLocation;
  final String newLocation;
  final DateTime dateTime; // Change from String to DateTime
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
      "dateTime": dateTime.toIso8601String(), // store as string
      "movedBy": movedBy,
    };
  }

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      oldLocation: json["oldLocation"],
      newLocation: json["newLocation"],
      dateTime: DateTime.parse(json["dateTime"]), // parse back to DateTime
      movedBy: json["movedBy"],
    );
  }
}
