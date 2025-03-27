import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import '../features/features.dart';
import 'core.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<PrefsDataSource>(
      (i) => PrefsDataSourceImpl(),
    ),
    Bind.singleton<AuthProvider>(
      (i) => AuthProviderImpl(
        prefs: i<PrefsDataSource>(),
      ),
    ),
    Bind.singleton<ApiClient>(
      (i) => ApiClient(
        baseUrl: EnvironmentConfig().apiBaseUrl,
      ),
    ),
    Bind.singleton<AuthRepository>(
      (i) => AuthRepositoryImpl(
        apiClient: i<ApiClient>(),
        service: i<PutFileService>(),
      ),
    ),
    Bind.singleton<AuthController>(
      (i) => AuthControllerImpl(
        repository: i(),
        authProvider: i(),
      ),
    ),
    Bind.singleton<NavBarController>(
      (i) => NavBarControllerImpl(
        authProvider: i(),
        authController: i<AuthController>(),
      ),
    ),
    Bind.singleton<PutFileService>(
      (i) => PutFileServiceImpl(),
    ),
    Bind.singleton<SendMailService>(
      (i) => SendMailServiceImpl(dio: Dio()),
    ),
    Bind.factory<LoginController>(
      (i) => LoginControllerImpl(
        authController: i(),
        authRepository: i(),
      ),
    ),
    Bind.factory<ForgotPasswordController>(
      (i) => ForgotPasswordControllerImpl(
        authRepository: i(),
      ),
    ),
    Bind.factory<CustomersController>(
      (i) => CustomersControllerImpl(
        repository: i(),
      ),
    ),
    Bind.factory<ContactController>(
      (i) => ContactControllerImpl(
        sendMailService: i(),
      ),
    ),
  ];

  static CustomTransition get defaultTransition =>
      CustomTransition(transitionBuilder: (_, __, ___, child) => child);

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        RoutesName.login.name,
        child: (_, args) => const LoginScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
      ),
      ChildRoute(
        RoutesName.forgotPassword.name,
        child: (_, args) => ForgotPasswordScreen(
          token: args.queryParams['token'],
        ),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
      ),
      ChildRoute(
        RoutesName.customers.name,
        child: (_, args) => const CustomersScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
      ),
      ModuleRoute(
        RoutesName.registration.name,
        module: RegistrationModule(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
      ),
      ModuleRoute(
        RoutesName.initial.name,
        guards: [AuthGuard()],
        module: HomeModule(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
      ),
      ChildRoute(
        RoutesName.contact.name,
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        child: (_, args) => const ContactScreen(),
      ),
    ];
  }
}
