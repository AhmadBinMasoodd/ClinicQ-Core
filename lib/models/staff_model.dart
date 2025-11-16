class Staff {
  final String id;
  final String name;
  final String role; // Nurse, Technician, Doctor, Admin, Porter, etc.
  final String cnic;
  final String phone;
  final String email;
  final String password;
  final String address;
  final String salary;
  final String assignedRoom; // Room they are currently responsible for

  Staff({
    required this.id,
    required this.name,
    required this.role,
    required this.cnic,
    required this.phone,
    required this.address,
    required this.salary,
    required this.assignedRoom,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "role": role,
      "cnic": cnic,
      "phone": phone,
      "address": address,
      "salary": salary,
      "assignedRoom": assignedRoom,
    };
  }

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json["id"],
      name: json["name"],
      role: json["role"],
      cnic: json["cnic"],
      phone: json["phone"],
      address: json["address"],
      salary: json["salary"],
      assignedRoom: json["assignedRoom"],
    );
  }
}
