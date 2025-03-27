import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/core.dart';
import 'components/components.dart';
import 'general_informations.dart';
import 'states/general_information_states.dart';

class GeneralInformationScreen extends StatefulWidget {
  const GeneralInformationScreen({Key? key}) : super(key: key);

  @override
  _GeneralInformationScreenState createState() =>
      _GeneralInformationScreenState();
}

class _GeneralInformationScreenState extends State<GeneralInformationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller = Modular.get<GeneralInformationController>();

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onRefreshScreen() {
    Navigator.of(context).pop();
    _controller.init();
  }

  void _showCreateNewMariaInformation({MariaInformation? description}) {
    ModalEditWhoIsMaria(
      context: context,
      description: description!,
      onClosed: _onRefreshScreen,
    ).show();
  }

  void _showEditOurService({MariaInformation? description}) {
    ModalEditOurService(
      context: context,
      onClosed: _onRefreshScreen,
      description: description!,
    ).show();
  }

  void _showEditServiceFees({MariaInformation? description}) {
    ModalEditServiceFees(
      context: context,
      description: description!,
      onClosed: _onRefreshScreen,
    ).show();
  }

  void _showCreateNewFaq({Faq? faq}) {
    ModalCreateNewFaq(
      faq: faq,
      context: context,
      onClosed: _onRefreshScreen,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BodyContentScreen(
        child: _body(),
        padding: Paddings.contentBodyOnlyTop(),
      ),
    );
  }

  Widget _title() {
    return const AutoSizeText(
      Strings.generalInformations,
      style: TextStyles.mariaTipsTitle,
      textAlign: TextAlign.center,
    );
  }

  Widget _body() {
    return StreamBuilder<GeneralInformationState>(
      stream: _controller.generalInformationStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is GeneralInformationErrorState) {
          return _errorState(states);
        }

        if (states is GeneralInformationLoadingState) {
          return const Center(
            child: Loading(),
          );
        }

        if (states is GeneralInformationSucessState) {
          return _content(states);
        }

        return Container();
      },
    );
  }

  Widget _errorState(GeneralInformationErrorState states) {
    return ErrorState(
      height: null,
      message: states.message,
      isButtonVisibility: true,
      textAlign: TextAlign.center,
      padding: Paddings.horizontal,
      onPressed: () => _controller.init(),
    );
  }

  Widget _content(GeneralInformationSucessState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 56,
        ),
        Expanded(
          child: _contentCards(state),
        ),
      ],
    );
  }

  Widget _contentCards(GeneralInformationSucessState state) {
    return Row(
      children: [
        Flexible(
          child: _cardsInformation(state),
        ),
        const HorizontalSpacing(
          width: 24.0,
        ),
        Flexible(
          child: _cardsInformationFaq(state),
        ),
      ],
    );
  }

  Widget _cardsInformation(GeneralInformationSucessState state) {
    return Column(
      children: [
        Flexible(
          child: CardGeneralInformation(
            title: Strings.whoIsMariaTitle,
            message: state.whoIsMaria.text,
            onEditInformation: () => _showCreateNewMariaInformation(
              description: state.whoIsMaria,
            ),
          ),
        ),
        const VerticalSpacing(
          height: 16,
        ),
        Flexible(
          child: CardGeneralInformation(
            title: Strings.costOfFreightTitle,
            message: state.ourService.text,
            onEditInformation: () => _showEditOurService(
              description: state.ourService,
            ),
          ),
        ),
        const VerticalSpacing(
          height: 16,
        ),
        Flexible(
          child: CardGeneralInformation(
            title: Strings.feesTitle,
            message: state.serviceFees.subtitle,
            onEditInformation: () => _showEditServiceFees(
              description: state.serviceFees,
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardsInformationFaq(GeneralInformationSucessState state) {
    return CardGeneralInformationFaq(
      faqs: state.faq,
      onRemoveFaq: _controller.handleRemoveFaq,
      onCreateNewFaq: () => _showCreateNewFaq(),
      onEditFaq: (faq) => _showCreateNewFaq(faq: faq),
    );
  }
}
