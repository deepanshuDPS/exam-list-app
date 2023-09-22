import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewImageSheet extends StatefulWidget {
  final String htmlContent;

  const ViewImageSheet({Key? key, required this.htmlContent}) : super(key: key);

  @override
  State<ViewImageSheet> createState() => _ViewImageSheetState();
}

class _ViewImageSheetState extends State<ViewImageSheet> {


  final WebViewController controller = WebViewController();


  @override
  void initState() {
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height/4 * 3,
        // padding: const EdgeInsets.all(20),
        child: WebViewWidget(
          controller: controller,
        ));
  }
}
