import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'forgot_password_controller.dart';
import 'states/change_password_state.dart';
import 'states/forgot_password_states.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? token;

  const ForgotPasswordScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final PageController _pageController;

  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();
  final _passwordConfirmFormFields = FormFields();

  final _controller = Modular.get<ForgotPasswordController>();

  @override
  void initState() {
    _setup();
    _startListener();
    super.initState();
  }

  void _setup() {
    if (widget.token != null) {
      _pageController = PageController(initialPage: 2);
    } else {
      _pageController = PageController(initialPage: 0);
    }
  }

  void _startListener() {
    _controller.forgotPasswordStateStream.listen((states) async {
      if (states is ForgotPasswordSucessState) {
        _animateTo(1);

        await Future.delayed(Durations.transitionToNavigate);
        Modular.to.pop();
      }
    });

    _controller.changePasswordStateStream.listen((states) async {
      if (states is ChangePasswordSucessState) {
        _animateTo(3);
      }
    });
  }

  void _handleSendEmailToChangePassword() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final email = _emailFormFields.getMaskValue;
      await _controller.handleSendEmail(email!);
    }
  }

  void _handleChangePassword() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final password = _passwordFormFields.getMaskValue;
      await _controller.handleChangePassword(widget.token, password!);
    }
  }

  void _animateTo(int page) {
    _pageController.animateToPage(
      page,
      curve: Curves.easeInOut,
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
    return Center(
      child: Container(
        constraints: Sizes.loginForms,
        child: Column(
          children: [
            const MariaMeEnviaLogo(),
            const VerticalSpacing(
              height: 24,
            ),
            Expanded(
              child: _forms(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forms() {
    return Form(
      key: _formKey,
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _sectionInsertEmailWidget(),
          _sendEmailResultSucess(),
          _sectionChangePassword(),
          _changePasswordResultSucess(),
        ],
      ),
    );
  }

  Widget _sectionInsertEmailWidget() {
    return StreamBuilder<ForgotPasswordState>(
      stream: _controller.forgotPasswordStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final forgotPasswordStates = snapshot.data;

        if (forgotPasswordStates is ForgotPasswordErrorState) {
          errorText = forgotPasswordStates.message;
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpacing(
              height: 48,
            ),
            _text(text: Strings.retrieveYourPasswordText),
            const VerticalSpacing(
              height: 32,
            ),
            _email(
              errorText: errorText,
              isEnabled: forgotPasswordStates is! ForgotPasswordLoadingState,
            ),
            _defaultButton(
              isLoading: forgotPasswordStates is ForgotPasswordLoadingState,
              onPressed: _handleSendEmailToChangePassword,
            ),
          ],
        );
      },
    );
  }

  Widget _text({
    String text = Strings.retrieveYourPasswordEmailTitleText,
  }) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: TextStyles.resgitrationHeaderTitle,
    );
  }

  Widget _email({
    String? errorText,
    bool isEnabled = true,
  }) {
    return TextFormField(
      enabled: isEnabled,
      textAlign: TextAlign.start,
      validator: Validators.email,
      textDirection: TextDirection.ltr,
      focusNode: _emailFormFields.focus,
      controller: _emailFormFields.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorText: errorText,
        labelText: Strings.emailInputLabelText,
        helperText: Strings.forgotPasswordInputHelperText,
      ),
      onFieldSubmitted: (_) => _handleSendEmailToChangePassword(),
    );
  }

  Widget _sendEmailResultSucess() {
    return const Padding(
      child: DoneFeedback(
        title: Strings.retrieveYourPasswordEmailTitleText,
        subtitle: Strings.retrieveYourPasswordContentText,
      ),
      padding: EdgeInsets.only(top: 80),
    );
  }

  Widget _sectionChangePassword() {
    return StreamBuilder<ChangePasswordState>(
      stream: _controller.changePasswordStateStream,
      builder: (context, snapshot) {
        String? errorText;
        final changePasswordState = snapshot.data;

        if (changePasswordState is ChangePasswordErrorState) {
          errorText = changePasswordState.message;
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _text(text: Strings.newPassword),
            const VerticalSpacing(
              height: 32,
            ),
            _statePasswordVisible(errorText),
            _defaultButton(
              onPressed: _handleChangePassword,
              isLoading: changePasswordState is ChangePasswordLoadingState,
            ),
          ],
        );
      },
    );
  }

  Widget _statePasswordVisible(String? errorMessage) {
    return StreamBuilder<bool>(
      stream: _controller.isPasswordVisibleStream,
      builder: (context, snapshot) {
        final bool isPasswordVisible = snapshot.data ?? true;
        return Column(
          children: [
            _password(isPasswordVisible),
            _passwordConfirmation(
              isPasswordVisible,
              errorMessage,
            ),
          ],
        );
      },
    );
  }

  Widget _password(bool isPasswordVisible) {
    return PasswordInputComponent(
      obscureText: isPasswordVisible,
      validator: Validators.password,
      formFields: _passwordFormFields,
      padding: Paddings.regsitartionFormFiels,
      labelText: Strings.newPasswordInputLabelText,
      onChangedObscureText: _controller.togglePasswordVisible,
      onFieldSubmitted: (_) {
        _passwordConfirmFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordConfirmation(
    bool isPasswordVisible,
    String? errorMessage,
  ) {
    return PasswordInputComponent(
      padding: Paddings.zero,
      errorText: errorMessage,
      obscureText: isPasswordVisible,
      textInputAction: TextInputAction.done,
      formFields: _passwordConfirmFormFields,
      labelText: Strings.passwordConfirmationInputLabelText,
      onChangedObscureText: _controller.togglePasswordVisible,
      validator: (value) {
        final password = _passwordFormFields.controller?.text;
        return Validators.confirmPassword(password, value);
      },
      onFieldSubmitted: (_) => _handleChangePassword(),
    );
  }

  Widget _defaultButton({
    required bool isLoading,
    required VoidCallback? onPressed,
    String text = Strings.forgotPasswordButtonTitleSend,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: DefaultButton(
        isValid: true,
        title: text,
        isLoading: isLoading,
        onPressed: onPressed,
      ),
    );
  }

  Widget _changePasswordResultSucess() {
    return const Padding(
      child: DoneFeedback(
        title: Strings.newPasswordCreated,
        subtitle: Strings.guardNewPassword,
      ),
      padding: EdgeInsets.only(top: 80),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _emailFormFields.dispose();
    _passwordFormFields.dispose();
    _passwordConfirmFormFields.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}
