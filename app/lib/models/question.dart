class Question {
  
  final int id;
  final String title;

  Question({required this.id, required this.title});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
    );
  }
}