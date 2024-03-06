import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(home: _WebViewExample()));
}

class _WebViewExample extends StatefulWidget {
  const _WebViewExample();

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<_WebViewExample> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _loadUrl();
  }

  Future<void> _loadUrl() async {
    try {
      await _controller.loadUrl('https://nci.cu.edu.eg/donate/');
    } catch (e) {
      print('Error loading URL: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NCI Donation Application'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onPageFinished: (_) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
