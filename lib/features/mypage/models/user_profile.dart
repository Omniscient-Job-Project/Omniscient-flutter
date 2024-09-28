class UserProfile {
  String? id;
  String name;
  String jobTitle;
  String email;
  String phone;
  int age;
  String address;
  List<String> certificates;
  bool status;
  List<String> profileImages;

  UserProfile({
    this.id,
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.age,
    required this.address,
    required this.certificates,
    required this.status,
    required this.profileImages,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      jobTitle: json['jobTitle'],
      email: json['email'],
      phone: json['phone'],
      age: json['age'],
      address: json['address'],
      certificates: List<String>.from(json['certificates']),
      status: json['status'],
      profileImages: List<String>.from(json['profileImages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'jobTitle': jobTitle,
      'email': email,
      'phone': phone,
      'age': age,
      'address': address,
      'certificates': certificates,
      'status': status,
      'profileImages': profileImages,
    };
  }
}
