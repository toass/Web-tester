import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnSearchPage extends StatefulWidget{
  OnSearchPage({Key? key, required this.link}) : super(key: key);

  String link;

  @override
  State<OnSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<OnSearchPage> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}