import 'package:flutter/material.dart';

import '../../../core/values/values.dart';

class NavBarOpenButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const NavBarOpenButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: const Icon(
        Icons.menu,
        size: 32,
        color: AppColors.secondary,
      ),
    );
  }
}
