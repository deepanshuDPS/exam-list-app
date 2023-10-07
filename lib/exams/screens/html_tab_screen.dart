import 'package:exam_list/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlTabScreen extends StatefulWidget {
  final String htmlContent;

  const HtmlTabScreen({Key? key, required this.htmlContent}) : super(key: key);

  @override
  State<HtmlTabScreen> createState() => _HtmlTabScreen();
}

class _HtmlTabScreen extends State<HtmlTabScreen> {
  final WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    if (widget.htmlContent.isNotEmpty) {
      controller
        ..enableZoom(true)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith("https://")) {
                // launchUrl(Uri.parse(request.url));
                return NavigationDecision.navigate;
              } else {
                return NavigationDecision.prevent;
              }
            },
          ),
        )
        ..loadHtmlString(widget.htmlContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          color: Colors.white,
          // padding: const EdgeInsets.all(20),
          child: WebViewWidget(
            controller: controller,
          )),
      Positioned(
        right: 32,
        bottom: 14,
        left: 32,
        child: Card(
          elevation: 1,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration:  BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              color: const Color(0xffECECEC).withOpacity(0.9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.zoom_in,
                  size: 24,
                  color: sharpGrey,
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Zoom In and Out by Pinching', style: TextStyle(color: sharpGrey, fontSize: 16, fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
