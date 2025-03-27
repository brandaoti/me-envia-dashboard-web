import 'package:maria_me_envia_mobile_admin_web/core/services/put_file/put_file.dart';

class CreateHints {
  final String? title;
  final String? link;
  final PutFile? putFile;
  final String? description;

  const CreateHints({
    required this.title,
    required this.link,
    required this.putFile,
    required this.description,
  });

  Map toApi() {
    final Map data = {};

    if (_hasData(title)) {
      data['title'] = title;
    }

    if (_hasData(description)) {
      data['description'] = description;
    }

    if (_hasData(link)) {
      data['link'] = link;
    }

    return data;
  }

  bool _hasData(String? value) => value != null && value.isNotEmpty;
}
