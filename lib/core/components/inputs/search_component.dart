import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class SearchComponent extends StatelessWidget {
  final FormFields fields;
  final VoidCallback onPressed;
  final ValueChanged<String>? onChanged;

  const SearchComponent({
    Key? key,
    required this.fields,
    required this.onPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 640,
        maxHeight: 48,
      ),
      child: Row(
        children: [
          _searchForm(),
          const HorizontalSpacing(width: 14),
          _searchButton(),
        ],
      ),
    );
  }

  Widget _searchForm() {
    return Expanded(
      child: TextFormField(
        onChanged: onChanged,
        focusNode: fields.focus,
        controller: fields.controller,
        onFieldSubmitted: (_) => onPressed(),
        decoration: InputDecoration(
          filled: true,
          border: Decorations.inputBorderForms,
          labelText: Strings.searchInputLabelText,
          fillColor: const Color(0xffCBCDDE).withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _searchButton() {
    return SizedBox(
      width: 48,
      child: DefaultButton(
        radius: 8,
        isValid: true,
        onPressed: onPressed,
        title: Strings.searchButton,
      ),
    );
  }
}
