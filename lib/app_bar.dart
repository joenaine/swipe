import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swifeeapp/constants/app_assets.dart';
import 'package:swifeeapp/constants/app_colors_const.dart';

import 'globals.dart';

class AppBarUrl extends StatefulWidget {
  final UrlWidgetController urlWidgetController;
  final Widget? widget;

  // ignore: use_key_in_widget_constructors
  const AppBarUrl({
    required this.urlWidgetController,
    this.widget,
  });

  @override
  State<AppBarUrl> createState() => AppBarUrlState(urlWidgetController);
}

class AppBarUrlState extends State<AppBarUrl> {
  AppBarUrlState(UrlWidgetController urlWidgetController) {
    urlWidgetController.setUrl = setUrl;
    urlWidgetController.setTitle = setTitle;
  }

  var title = '';
  var url = '';

  void setUrl() {
    setState(() {
      url = urlGlobal;
    });
  }

  void setTitle() {
    setState(() {
      title = titleGlobal;
    });
  }

  @override
  Widget build(BuildContext context) {
    var topBar = MediaQuery.of(context).viewPadding.top;
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.height * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(AppAssets.svg.lock),
            Container(
              width: size.width * .6,
              decoration: BoxDecoration(
                  color: AppColors.grey25,
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: const Text(
                'dataasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdaasds',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SvgPicture.asset(
              AppAssets.svg.update,
            ),
            SvgPicture.asset(
              AppAssets.svg.lamp,
            ),
            SvgPicture.asset(
              AppAssets.svg.moreVertical,
            ),
          ],
        ));
  }
}
