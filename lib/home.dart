import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swifeeapp/constants/app_assets.dart';
import 'package:swifeeapp/constants/app_colors_const.dart';
import 'package:swifeeapp/gest.dart';
import 'package:swifeeapp/constants/globals.dart';
import 'package:swifeeapp/repos/list.dart';
import 'package:swifeeapp/repos/topics.dart';
import 'package:swifeeapp/topic_app_bar.dart';

import 'app_bar.dart';
import 'constants/globals.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  ScrollController? scroll;
  late PullToRefreshController pullController;

  var themeAppBarSelected = false;
  double progress = 0;
  InAppWebViewController? webViewController;

  var durationSwipePost = const Duration(seconds: 1);
  var x = 0;
  var y = 0;
  final PageController horizontalController = PageController();

  @override
  void initState() {
    super.initState();
    pullController = PullToRefreshController(
      onRefresh: () {
        navIndex--;
      },
    );
  }

  void scrollWebView(xWebView, yWebView) {
    if (y < yWebView) {
      themeAppBarSelected = true;
    } else {
      themeAppBarSelected = false;
    }
    setState(() {});
    y = yWebView;
  }

  static ValueKey key = const ValueKey('key_0');
  final PageController _verticalController = PageController();
  final PageController _horizontalController = PageController();

  void navToPage(int index) {
    _verticalController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  int pageNumber = 0;
  bool pageIsScrolling = false;
  late int navIndex;
  late int pageSize;
  late String? urlRecord = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: themeAppBarSelected ? size.height * .1 : 0,
                curve: Curves.ease,
                child: AppBarUrl(
                  urlWidgetController: urlController,
                  url: urlRecord!,
                )),
            AnimatedContainer(
                height: themeAppBarSelected ? 0 : size.height * .1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                child: TopicAppBar(
                  listOfTopics: topics,
                  indexActive: pageNumber,
                )),
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        pageNumber = value;
                      });
                    },
                    controller: _horizontalController,
                    itemCount: webs.length,
                    itemBuilder: (context, index) {
                      return PageView.builder(
                        controller: _verticalController,
                        scrollDirection: Axis.vertical,
                        itemCount: webs.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, insideIndex) {
                          pageSize = webs[index].length;
                          navIndex = insideIndex;

                          int sizeOfWebs = 0;
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: InAppWebView(
                                  gestureRecognizers: {
                                    Factory(() =>
                                        PlatformViewVerticalGestureRecognizer(
                                          kind: PointerDeviceKind.touch,
                                        )),
                                  },
                                  onScrollChanged: (controller, x, y) {
                                    scrollWebView(x, y);
                                  },
                                  // onLoadStop: (controller, uri) {
                                  //   setState(() {
                                  //     urlRecord = uri!.toString();
                                  //   });
                                  // },
                                  onUpdateVisitedHistory:
                                      (controller, uri, androidIsReload) {
                                    setState(() {
                                      urlRecord = uri!.toString();
                                    });
                                  },

                                  // pullToRefreshController: pullController,
                                  initialUrlRequest: URLRequest(
                                    url: Uri.parse(webs[index][insideIndex]),
                                  ),
                                  onWebViewCreated: (controller) async {
                                    webViewController = controller;
                                    webViewController?.addJavaScriptHandler(
                                        handlerName: 'themeAppBar',
                                        callback: (args) {
                                          setState(() {
                                            themeAppBarSelected =
                                                !themeAppBarSelected;
                                          });
                                          print("Плашка двигается!");
                                        });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(AppAssets.svg.settings),
                          InkWell(
                              onTap: () {
                                if (navIndex < pageSize - 1) {
                                  navIndex++;
                                }
                                print('index' '$navIndex');
                                navToPage(navIndex);
                              },
                              child: SvgPicture.asset(AppAssets.svg.moveTop)),
                          SvgPicture.asset(AppAssets.svg.profile),
                        ],
                      ),
                    ),
                  ),
                  // Align(
                  //     alignment: Alignment.topCenter,
                  //     child: ClipRect(
                  //       child: BackdropFilter(
                  //         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: (MediaQuery.of(context).size.height * 0.1),
                  //           color: AppColors.dark,
                  //         ),
                  //       ),
                  //     )),
                  // AnimatedPositioned(
                  //     duration: const Duration(seconds: 1),
                  //     top: themeAppBarSelected ? -200 : 0,
                  //     curve: Curves.ease,
                  //     child: AppBarUrl(urlWidgetController: urlController)),
                  // AnimatedPositioned(
                  //     top: themeAppBarSelected ? 0 : -200,
                  //     duration: const Duration(seconds: 1),
                  //     curve: Curves.ease,
                  //     child: TopicAppBar(
                  //       listOfTopics: topics,
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll(double offset) {
    if (pageIsScrolling == false) {
      pageIsScrolling = true;
      if (offset > 0) {
        _verticalController
            .nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false);

        print('scroll down');
      } else {
        _verticalController
            .previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut)
            .then((value) => pageIsScrolling = false);
        print('scroll up');
      }
    }
  }
}

// ElevatedButton(
//                               onPressed: () {
//                                 if (navIndex < webs[index].length - 1) {
//                                   navIndex++;
//                                 }
//                                 print('index' '$navIndex');
//                                 navToPage(navIndex);
//                               },
//                               child: const Text('data'))
