import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swifeeapp/gest.dart';
import 'package:swifeeapp/repos/list.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static ValueKey key = const ValueKey('key_0');
  final PageController _verticalController = PageController();

  void navToPage(int index) {
    _verticalController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (pageNumber < webs.length) {
          pageNumber++;
        }
        print(pageNumber);
        navToPage(pageNumber);
      }),
      body: PageView.builder(
        itemCount: webs.length,
        itemBuilder: (context, index) {
          return PageView.builder(
            controller: _verticalController,
            scrollDirection: Axis.vertical,
            itemCount: webs.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, insideIndex) {
              int pageSize = webs[index].length;
              int navIndex = insideIndex;
              int sizeOfWebs = 0;
              return Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Center(
                      child: WebView(
                        initialUrl: webs[index][insideIndex],
                        gestureRecognizers: {
                          Factory(() => PlatformViewVerticalGestureRecognizer(
                                kind: PointerDeviceKind.touch,
                              )),
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          if (navIndex < webs[index].length - 1) {
                            navIndex++;
                          }
                          print('index' '$navIndex');
                          navToPage(navIndex);
                        },
                        child: const Text('data')),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
