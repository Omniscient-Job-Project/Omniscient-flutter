class Certificate {
  final String id;
  final String name;
  final String date;
  final String issuer;
  final String number;

  Certificate({
    required this.id,
    required this.name,
    required this.date,
    required this.issuer,
    required this.number,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      issuer: json['issuer'],
      number: json['number'],
    );
  }
}
