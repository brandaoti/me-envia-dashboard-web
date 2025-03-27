import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ContactLocation extends StatelessWidget {
  const ContactLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Helper.launchTo(Strings.addressMary),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Card(
          margin: Paddings.zero,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset(
                Images.address,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   height: 500,
    //   width: double.infinity,
    //   child: Image.asset(Images.address),
    //   decoration: BoxDecoration(
    //     color: AppColors.white,
    //     borderRadius: BorderRadius.circular(16),
    //     // image: const DecorationImage(image: AssetImage(Images.address)),
    //   ),
    // );
  }
}
