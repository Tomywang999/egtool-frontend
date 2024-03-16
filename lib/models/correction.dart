class Correction {
  int grade;
  String sample;
  String feedback;
  String questions;
  String useranswers;

  Correction({
    required this.grade,
    required this.sample,
    required this.feedback,
    required this.questions,
    required this.useranswers,
  });

  factory Correction.fromJson(Map<String, dynamic> json) {
    return Correction(
      grade: json['grade'],
      sample: json['sample'],
      feedback: json['feedback'],
      questions: json['questions'],
      useranswers: json['useranswers'],
    );
  }
}
