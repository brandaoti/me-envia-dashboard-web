class CreateNewFaq {
  final String question;
  final String answer;

  const CreateNewFaq({
    required this.question,
    required this.answer,
  });

  Map toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
