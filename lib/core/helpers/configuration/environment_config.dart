class EnvironmentConfig {
  late String apiBaseUrl;
  late String mailUserId;
  late String mailServiceId;
  late String mailTemplateId;

  EnvironmentConfig._();

  static EnvironmentConfig? _instance = EnvironmentConfig._();

  factory EnvironmentConfig() {
    return _instance!;
  }

  void _setUrls({
    required String apiUrl,
    required String userId,
    required String serviceId,
    required String templateId,
  }) {
    _instance!.apiBaseUrl = apiUrl;
    _instance!.mailUserId = userId;
    _instance!.mailServiceId = serviceId;
    _instance!.mailTemplateId = templateId;
  }

  static Future<void> configure() async {
    _instance ??= EnvironmentConfig._();

    const apiUrlEnv = String.fromEnvironment('BASE_URL');
    const userIdEnv = String.fromEnvironment('USER_ID');
    const serviceIdEnv = String.fromEnvironment('SERVICE_ID');
    const templateIdEnv = String.fromEnvironment('TEMPLATE_ID');

    _instance!._setUrls(
      apiUrl: apiUrlEnv,
      userId: userIdEnv,
      serviceId: serviceIdEnv,
      templateId: templateIdEnv,
    );
  }
}
