import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'contact_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _controller = Modular.get<ContactController>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: _header(),
    );
  }

  PreferredSizeWidget _header() {
    return const ContactHeader();
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Content(),
          TalkToMe(controller: _controller),
          const ContactFooter(),
        ],
      ),
    );
  }
}
