import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

import 'login_controller.dart';
import 'states/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailFormFields = FormFields();
  final _passwordFormFields = FormFields();

  final _controller = Modular.get<LoginController>();

  @override
  void dispose() {
    _emailFormFields.dispose();
    _passwordFormFields.dispose();
    _formKey.currentState?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitButton() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    final email = _emailFormFields.controller?.text ?? '';
    final password = _passwordFormFields.controller?.text ?? '';

    await _controller.handleSubmit(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        isScrollable: true,
        child: Container(
          child: _body(),
          constraints: Sizes.loginForms,
        ),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<LoginState>(
      stream: _controller.loginStateStream,
      builder: (context, snapshot) {
        bool isLoading = false;
        String? errorMessage;
        final loginState = snapshot.data;

        if (loginState is LoginLoadingState) {
          isLoading = true;
        }

        if (loginState is LoginErrorState) {
          isLoading = false;
          errorMessage = loginState.message;
        }

        return Column(
          children: [
            const MariaMeEnviaLogo(),
            const VerticalSpacing(
              height: 80,
            ),
            _forms(!isLoading, errorMessage),
            const VerticalSpacing(
              height: 40,
            ),
            _actionsButtons(isLoading),
          ],
        );
      },
    );
  }

  Widget _forms(
    bool isEnable,
    String? loginErrorMessage,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _emailForm(isEnable),
          const VerticalSpacing(
            height: 16,
          ),
          _passwordForm(isEnable, loginErrorMessage),
        ],
      ),
    );
  }

  Widget _actionsButtons(bool isLoading) {
    return Column(
      children: [
        _loginBtn(isLoading),
        const VerticalSpacing(
          height: 16,
        ),
        _registerBtn(!isLoading),
        const VerticalSpacing(
          height: 16,
        ),
        _forgotPasswordBtn(!isLoading),
      ],
    );
  }

  Widget _emailForm(bool isEnable) {
    return TextFormField(
      enabled: isEnable,
      validator: Validators.email,
      focusNode: _emailFormFields.focus,
      controller: _emailFormFields.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.emailInputLabelText,
        fillColor: const Color(0xffCBCDDE).withOpacity(0.2),
      ),
      onFieldSubmitted: (_) {
        _passwordFormFields.focus?.requestFocus();
      },
    );
  }

  Widget _passwordForm(bool isEnable, String? errorText) {
    return StreamBuilder<bool>(
      stream: _controller.isPasswordVisibleStream,
      builder: (context, snapshot) {
        final bool isPasswordVisible = snapshot.data ?? true;
        return PasswordInputComponent(
          errorMaxLines: 2,
          errorText: errorText,
          obscureText: isPasswordVisible,
          formFields: _passwordFormFields,
          onFieldSubmitted: (_) => _handleSubmitButton(),
          onChangedObscureText: _controller.togglePasswordVisible,
        );
      },
    );
  }

  Widget _loginBtn(bool isLoading) {
    return DefaultButton(
      isValid: true,
      isLoading: isLoading,
      title: Strings.loginButtonTitle,
      onPressed: _handleSubmitButton,
    );
  }

  Widget _registerBtn(bool isEnable) {
    return RoundedButton(
        title: Strings.registerButtonTitle,
        onPressed: _controller.navigateToResgisterScreen);
  }

  Widget _forgotPasswordBtn(bool isEnable) {
    return BordLessButton(
        title: Strings.forgotPasswordButtonTitle,
        onPressed: _controller.navigateToForgotPasswordScreen);
  }
}
