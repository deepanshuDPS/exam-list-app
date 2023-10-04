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
    if(widget.htmlContent.isNotEmpty){
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
    return Container(
        color: Colors.white,
        // padding: const EdgeInsets.all(20),
        child: WebViewWidget(
          controller: controller,
        ));
  }
}
