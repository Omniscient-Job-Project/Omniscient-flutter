class Certificate {
  final String name;
  final String date;
  final String issuer;
  final String number;

  Certificate({
    required this.name,
    required this.date,
    required this.issuer,
    required this.number,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      name: json['name'],
      date: json['date'],
      issuer: json['issuer'],
      number: json['number'],
    );
  }
}
