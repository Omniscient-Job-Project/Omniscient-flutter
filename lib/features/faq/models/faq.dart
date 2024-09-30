class Faq {
  final int faqId;
  final String question;
  final String answer;
  final int faqViews;

  Faq({
    required this.faqId,
    required this.question,
    required this.answer,
    required this.faqViews,
  });

  Faq copyWith({
    int? faqId,
    String? question,
    String? answer,
    int? faqViews,
  }) {
    return Faq(
      faqId: faqId ?? this.faqId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      faqViews: faqViews ?? this.faqViews,
    );
  }

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      faqId: json['faqId'],
      question: json['question'],
      answer: json['answer'],
      faqViews: json['faqViews'],
    );
  }
}
