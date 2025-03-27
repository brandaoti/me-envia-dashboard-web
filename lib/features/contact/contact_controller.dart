import 'package:flutter/cupertino.dart';

import '../../core/core.dart';

abstract class ContactController {
  ValueNotifier<bool> get isSendFeedback;

  Future<void> handleSendFeedback({
    required String name,
    required String email,
    required String phone,
    required String message,
  });

  void dispose();
}

class ContactControllerImpl implements ContactController {
  final SendMailService sendMailService;

  ContactControllerImpl({
    required this.sendMailService,
  });

  final ValueNotifier<bool> _state = ValueNotifier<bool>(false);

  @override
  ValueNotifier<bool> get isSendFeedback => _state;

  void onChangeState(bool newState) {
    _state.value = newState;
  }

  @override
  void dispose() {
    _state.dispose();
  }

  @override
  Future<void> handleSendFeedback({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      onChangeState(true);
      await sendMailService.sendFeedbackToSuppotApplication(
        mail: Mail(name: name, email: email, phone: phone, message: message),
      );
    } catch (_) {} finally {
      onChangeState(false);
    }
  }
}
