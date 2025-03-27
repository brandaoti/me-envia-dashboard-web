import 'package:cubos_widgets/horizontal_spacing.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../core.dart';

class OpenPhotoFile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Radius radius;
  final VoidCallback onPressed;
  final Stream<OpenPhotoFileState> stream;

  const OpenPhotoFile({
    Key? key,
    required this.stream,
    required this.onPressed,
    this.icon = Icons.camera_alt_rounded,
    this.radius = const Radius.circular(20),
    this.text = Strings.photoFileUploadTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OpenPhotoFileState>(
      stream: stream,
      builder: (context, snapshot) {
        final states = snapshot.data;

        const mappinColorState = {
          OpenPhotoFileInitalState: AppColors.secondary,
          OpenPhotoFileSucessState: AppColors.alertGreenColor,
          OpenPhotoFileErrorState: AppColors.alertRedColor,
        };

        return InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: DottedBorder(
            radius: radius,
            child: _body(states),
            dashPattern: const [8],
            borderType: BorderType.RRect,
            color: mappinColorState[states.runtimeType] ?? AppColors.secondary,
          ),
        );
      },
    );
  }

  Widget _body(OpenPhotoFileState? states) {
    return Container(
      height: 198,
      width: double.infinity,
      alignment: Alignment.center,
      child: _chooseContentWithOpenProofOfPaymentState(states),
    );
  }

  Widget _chooseContentWithOpenProofOfPaymentState(
    OpenPhotoFileState? states,
  ) {
    if (states == null || states is OpenPhotoFileInitalState) {
      return _initialState();
    }

    if (states is OpenPhotoFileSucessState) {
      return _sucessState(
        putFile: states.putFile,
        isNetworkImage: states.isNetworkImage,
      );
    }

    if (states is OpenPhotoFileErrorState) {
      return _errorState(message: states.message);
    }

    return Container();
  }

  Widget _initialState() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 64,
          color: AppColors.secondary,
        ),
        const HorizontalSpacing(width: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 160,
          ),
          child: AutoSizeText(
            text,
            style: TextStyles.createNewItemsFile,
          ),
        )
      ],
    );
  }

  Widget _sucessState({
    required PutFile putFile,
    required bool isNetworkImage,
  }) {
    late final Widget child;

    if (isNetworkImage) {
      final source = putFile as PutNetworkImage;
      child = PlatformImage.element(source.path!, radius: 20);
    } else {
      final putFileImage = putFile as PutFileImage;
      child = Image.memory(putFileImage.bytes!);
    }

    return Container(
      height: 198,
      width: double.infinity,
      alignment: Alignment.center,
      child: IgnorePointer(child: child),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _errorState({String? message}) {
    const color = AppColors.alertRedColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          child: const Icon(Icons.close_rounded, color: color),
        ),
        const HorizontalSpacing(width: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 160),
          child: AutoSizeText(
            message ?? Strings.photoFileOpenError,
            style: TextStyles.createNewItemsFile,
          ),
        ),
      ],
    );
  }
}
