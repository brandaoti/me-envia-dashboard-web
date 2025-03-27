import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../features.dart';

import 'registration_controller.dart';
import 'states/registration_state.dart';
import 'registration.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);

  late final RegistrationController _controller;
  late final UserFormFieldsController _userInformationController;

  @override
  void initState() {
    _controller = Modular.get<RegistrationController>();
    _userInformationController = Modular.get<UserFormFieldsController>();

    _startListerner();
    super.initState();
  }

  void _startListerner() {
    _controller.registrationStateStream.listen((states) {
      if (states is RegistrationSuccessState) {
        _animateToPage(1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
    _formKey.currentState?.dispose();
    _userInformationController.dispose();
  }

  void _onFinishRegistration() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final userInformation = _userInformationController.getUserInformation();

    await _controller.handleRegistrationNewUser(
      userInformation: userInformation,
    );
  }

  void _animateToPage(int index) async {
    _pageController.animateToPage(
      index,
      curve: Curves.easeIn,
      duration: Durations.transition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        child: _body(),
        isScrollable: true,
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<RegistrationState>(
      stream: _controller.registrationStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final states = snapshot.data;

        final bool isRegistred = states is RegistrationSuccessState;

        if (states is RegistrationErrorState) {
          errorText = states.message;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            VerticalSpacing(
              height: isRegistred ? 160 : 40,
            ),
            const MariaMeEnviaLogo(),
            const VerticalSpacing(
              height: 24,
            ),
            _content(
              message: errorText,
              isLoading: states is RegistrationLoadingState,
            ),
          ],
        );
      },
    );
  }

  Widget _content({
    String? message,
    bool isLoading = false,
  }) {
    return Container(
      constraints: Sizes.registrationForms,
      child: _forms(
        message: message,
        isLoading: isLoading,
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.resgitrationHeaderTitle,
      style: TextStyles.resgitrationHeaderTitle,
    );
  }

  Widget _forms({
    String? message,
    bool isLoading = false,
  }) {
    return Form(
      key: _formKey,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          UserFormFields(
            isLoading: isLoading,
            headerWidget: _title(),
            onSubmitted: _onFinishRegistration,
            controller: _userInformationController,
            errorWidget: Visibility(
              child: _errorText(message: message),
              visible: message != null && message.isNotEmpty,
            ),
          ),
          _registrationResultSucessSection()
        ],
      ),
    );
  }

  Widget _registrationResultSucessSection() {
    return const Padding(
      child: DoneFeedback(),
      padding: EdgeInsets.only(top: 80),
    );
  }

  Widget _errorText({String? message}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      child: AutoSizeText(
        message ?? '',
        textAlign: TextAlign.center,
        style: TextStyles.resgitrationHeaderTitle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.alertRedColor,
        ),
      ),
    );
  }
}
