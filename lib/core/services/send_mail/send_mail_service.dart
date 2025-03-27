import 'package:dio/dio.dart';

import '../../core.dart';

abstract class SendMailService {
  Future<void> sendFeedbackToSuppotApplication({required Mail mail});
}

class SendMailServiceImpl implements SendMailService {
  final Dio dio;
  final String baseUrl;

  const SendMailServiceImpl({
    required this.dio,
    this.baseUrl = Strings.sendMailServiceApiUrl,
  });

  @override
  Future<void> sendFeedbackToSuppotApplication({required Mail mail}) async {
    try {
      final data = {
        'template_params': mail.toMap(),
        'user_id': EnvironmentConfig().mailUserId,
        'service_id': EnvironmentConfig().mailServiceId,
        'template_id': EnvironmentConfig().mailTemplateId,
      };
      await dio.post(baseUrl, data: data);
    } catch (e) {
      throw Failure(message: Strings.erroSendFeedbackMail);
    }
  }
}
