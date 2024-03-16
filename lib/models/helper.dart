class Helper {
  String mode;
  String correctanswer;
  String explanation;
  String question;
  String useranswers;

  Helper({
    required this.mode,
    required this.explanation,
    required this.question,
    required this.useranswers,
    required this.correctanswer,
  });

  factory Helper.fromJson(Map<String, dynamic> json) {
    return Helper(
      mode: json['sample'],
      correctanswer: json['correctanswer'],
      explanation: json['explanation'],
      question: json['question'],
      useranswers: json['useranswers'],
    );
  }
}
