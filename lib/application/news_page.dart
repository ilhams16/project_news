import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  NewsPage({required this.url});
  late String url;
  @override
  State<NewsPage> createState() => _NewsPageState(url: this.url);
}

class _NewsPageState extends State<NewsPage> {
  late String url;
  _NewsPageState({required this.url});
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News BSI"),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
