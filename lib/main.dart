import 'package:flutter/material.dart';
import 'package:webview_windows/webview_windows.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewPage(),
            debugShowCheckedModeBanner: false,

    );
  }
}

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final WebviewController _controller = WebviewController();
  bool _isWebViewReady = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    await _controller.initialize();
    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.loadUrl('http://192.168.2.36:8080/va-ux/');

    setState(() {
      _isWebViewReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: _isWebViewReady
          ? Webview(
              _controller,
              permissionRequested: (url, permission, bool) {
                return Future.value(WebviewPermissionDecision.allow);
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
