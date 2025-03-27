import 'package:auto_size_text/auto_size_text.dart';
import 'package:cubos_widgets/vertical_spacing.dart';
import 'package:flutter/material.dart';

import '../../../core/components/components.dart';
import '../../../core/values/values.dart';
import '../models/create_item_type.dart';

class CreateItemWidget extends StatelessWidget {
  final CreateItemType type;
  final VoidCallback onOpenFile;
  final VoidCallback onRemoveItem;
  final VoidCallback onConfirmAddItem;
  final Stream<OpenPhotoFileState> stream;
  final FormFields optinalItemNameFormField;

  const CreateItemWidget({
    Key? key,
    required this.type,
    required this.stream,
    required this.onOpenFile,
    required this.onRemoveItem,
    required this.onConfirmAddItem,
    required this.optinalItemNameFormField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _body(),
        _actionsButton(),
      ],
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const VerticalSpacing(
          height: 28,
        ),
        OpenPhotoFile(
          stream: stream,
          onPressed: onOpenFile,
        ),
        const VerticalSpacing(
          height: 24,
        ),
        _itemNameTextFormField(),
      ],
    );
  }

  Widget _itemNameTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      focusNode: optinalItemNameFormField.focus,
      controller: optinalItemNameFormField.controller,
      decoration: InputDecoration(
        filled: true,
        border: Decorations.inputBorderForms,
        labelText: Strings.titleInputLabelText,
        helperText: Strings.helperInputLabelText,
        fillColor: const Color(0xffCBCDDE).withOpacity(0.2),
      ),
    );
  }

  Widget _title() {
    return SizedBox(
      width: double.infinity,
      child: AutoSizeText(
        Strings.addeItems,
        textAlign: TextAlign.left,
        style: TextStyles.noConnectionTitle.copyWith(
          fontSize: 24,
          color: AppColors.secondary,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _actionsButton() {
    return Column(
      children: [
        _removeNewItemButton(),
        _finishButton(),
      ],
    );
  }

  Widget _removeNewItemButton() {
    return Visibility(
      visible: type == CreateItemType.edit,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: RoundedButton(
          isValid: true,
          onPressed: onRemoveItem,
          title: Strings.deleteNewItems,
        ),
      ),
    );
  }

  Widget _finishButton() {
    return StreamBuilder<OpenPhotoFileState>(
      stream: stream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: DefaultButton(
            onPressed: onConfirmAddItem,
            title: Strings.finishRegistration,
            isValid: snapshot.data is! OpenPhotoFileErrorState,
          ),
        );
      },
    );
  }
}
