import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swifeeapp/gest.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static ValueKey key = const ValueKey('key_0');
  final PageController _listController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(onPressed: () {
        _listController.animateToPage(1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }),
      body: PageView(
        children: [
          PageView(
              controller: _listController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: WebView(
                      initialUrl: 'https://flutter.dev/docs',
                      gestureRecognizers: {
                        Factory(() => PlatformViewVerticalGestureRecognizer(
                              kind: PointerDeviceKind.touch,
                            )),
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: WebView(
                      initialUrl: 'https://vk.com',
                      gestureRecognizers: {
                        Factory(() => PlatformViewVerticalGestureRecognizer(
                              kind: PointerDeviceKind.touch,
                            )),
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: WebView(
                      initialUrl: 'https://www.youtube.com/watch?v=RA-vLF_vnng',
                      gestureRecognizers: {
                        Factory(() => PlatformViewVerticalGestureRecognizer(
                              kind: PointerDeviceKind.touch,
                            )),
                      },
                    ),
                  ),
                ),
              ]),
          SizedBox(
            height: size.height,
            width: size.width,
            child: const Center(
              child: Text(
                'Page 2',
                style: TextStyle(fontSize: 72),
              ),
            ),
          ),
          SizedBox(
            height: size.height,
            width: size.width,
            child: const Center(
              child: Text(
                'Page 3',
                style: TextStyle(fontSize: 72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
