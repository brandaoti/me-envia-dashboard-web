import '../../../core/services/services.dart';

class CreateTips {
  String? title;
  String? link;
  PutFile? putFile;
  String? description;

  CreateTips({
    this.title,
    this.link,
    this.putFile,
    this.description,
  });

  bool get mediaNoContaisData => putFile == null;

  bool get isEmptyFields =>
      mediaNoContaisData &&
      (title ?? '').isEmpty &&
      (description ?? '').isEmpty;

  @override
  String toString() {
    return 'CreateTips(title: $title, link: $link, putFile: $putFile, description: $description)';
  }
}
