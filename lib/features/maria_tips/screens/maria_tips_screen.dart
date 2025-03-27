import 'package:flutter_modular/flutter_modular.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../maria_tips.dart';

class MariaTipsScreen extends StatefulWidget {
  const MariaTipsScreen({Key? key}) : super(key: key);

  @override
  _MariaTipsScreenState createState() => _MariaTipsScreenState();
}

class _MariaTipsScreenState extends State<MariaTipsScreen> {
  final _controller = Modular.get<MariaTipsController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _showModlaCreateNewTip({MariaTips? tips}) {
    ModalCreateNewTip(
      tips: tips,
      context: context,
      onClosed: _onRefreshScreen,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BodyContentScreen(child: _body()),
    );
  }

  Widget _body() {
    return StreamBuilder<MariaTipsState>(
      stream: _controller.mariaTipsStateStream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        if (states is MariaTipsLoadingState) {
          return const Center(
            child: Loading(),
          );
        }

        if (states is MariaTipsSucessState) {
          return _content(states.tips);
        }
        if (states is MariaTipsErrorState) {
          return _errorWidget(states.message);
        }

        return Container();
      },
    );
  }

  Widget _errorWidget(String message) {
    return Center(
      child: ErrorState(
        height: null,
        message: message,
        isButtonVisibility: true,
        onPressed: _controller.init,
        textAlign: TextAlign.center,
        padding: Paddings.horizontal,
      ),
    );
  }

  Widget _content(MariaTipsList tips) {
    return SingleChildScrollView(
      padding: Paddings.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TotalTips(
            totalTips: tips.length,
            addNewTipButtonWidget: _addNewTipButton(),
          ),
          const VerticalSpacing(
            height: 38,
          ),
          _listOfMariaTips(tips),
          const VerticalSpacing(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _listOfMariaTips(MariaTipsList tips) {
    const double minHeight = 460;
    if (tips.isEmpty) {
      return EmptyBoxIllustration(
        allIllustrationSize: 224,
        fillEveryLineOfText: true,
        message: Strings.noTipaCreated,
        additionalWidget: Padding(
          padding: Paddings.inputPaddingForms,
          child: _addNewTipButton(size: const Size(220, 40)),
        ),
        constraints: const BoxConstraints(
          minHeight: minHeight,
          minWidth: double.infinity,
        ),
      );
    }

    return Column(children: tips.map(_cardMariaTips).toList());
  }

  Widget _cardMariaTips(MariaTips mariaTips) {
    return CardMariaTipsComponent(
      mariaTips: mariaTips,
      onTap: () => _showModlaCreateNewTip(tips: mariaTips),
    );
  }

  Widget _addNewTipButton({Size size = const Size(80, 40)}) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: DefaultButton(
        radius: 8,
        fontSize: 14,
        isValid: true,
        minFontSize: 12,
        title: Strings.createNewTip,
        onPressed: _showModlaCreateNewTip,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      ),
    );
  }
}
