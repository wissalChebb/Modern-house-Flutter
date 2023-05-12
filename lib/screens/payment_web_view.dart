import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  PaymentWebView({Key? key, required this.paymen_url}) : super(key: key);
  final String paymen_url;
  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.paymen_url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            controller = webViewController;
            controller.loadUrl(widget.paymen_url);
          },
          navigationDelegate: (navigationDelegate) async {
            if (navigationDelegate.url.startsWith(
                'https://dev.konnect.network/gateway/payment-success')) {
              // Handle payment success
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        );
      }),
    );
  }
}
