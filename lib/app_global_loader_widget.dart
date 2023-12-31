import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swifeeapp/constants/app_colors_const.dart';

class AppLoaderWidget extends StatelessWidget {
  AppLoaderWidget({
    Key? key,
  }) : super(key: key);
  final isLoading = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            height: 20,
            width: 20,
            child: Platform.isAndroid
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.grey50,
                    backgroundColor: Colors.white)
                : const CupertinoActivityIndicator()));
  }
}
