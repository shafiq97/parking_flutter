import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final String url;
  final VoidCallback onSuccess;

  PaymentWebView({required this.url, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar or show progress indicator
          },
          onPageStarted: (String url) {
            // Handle actions when a page starts loading
          },
          onPageFinished: (String url) {
            // Check if the payment was successful
            if (url.contains('success')) {
              onSuccess();
            }
          },
          onWebResourceError: (WebResourceError error) {
            // Handle errors
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
