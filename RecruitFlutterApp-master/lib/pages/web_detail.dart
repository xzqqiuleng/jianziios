import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:recruit_app/colours.dart';

class WebPage extends StatelessWidget{
  String url;
 WebPage(this.url);


  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(

      body: WebviewScaffold(
          url: url)


    );

  }

}