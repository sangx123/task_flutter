
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/home/web_notifier.dart';
import 'package:flutter_deer/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  const WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
     this.needBack=true
  }) : super(key: key);
  final bool needBack;
  final String title;
  final String url;
  static const String routeName = 'ftvpn://brower';
  static const String TITLE = 'title';
  static const String URL = 'url';
  static const String HTML = 'html';
  //这个字符串表示返回到首页
  static const String BACK_APP="backApp";
  @override
  _WebViewPageState createState() => _WebViewPageState(title: title, url: url, needBack: needBack);
}

class _WebViewPageState extends State<WebViewPage> {
  _WebViewPageState({this.title, this.url, this.needBack});
  bool needBack = true;
  String url;
  String title = '';
  String html;
  WebNotifier _notifier;
  WebViewController _webViewController;
  bool needReloadTitle = false;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    _notifier ??= WebNotifier();

    final dynamic obj = ModalRoute.of(context).settings.arguments;
    print('build webview get ' + obj.toString());
    title ??= '';
    needBack ??= true;
    if (obj != null && title == '') {
      title = obj[WebViewPage.TITLE] as String;
      url = obj[WebViewPage.URL] as String;
      html = obj[WebViewPage.HTML] as String;
      print('webview url:' + url);
      if (title == null || title == '') {
        title = '';
        needReloadTitle = true;
      }
    }
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: (){
              return _goBack(context);
            },
          child: ChangeNotifierProvider<WebNotifier>(
          create: (_) => _notifier,
          child: Scaffold(
//                appBar: MyAppBar(
//                  centerTitle: widget.title,
//                  hasLine: false,
//                ),
            body: Consumer<WebNotifier>(
              builder: (
                  BuildContext context,
                  WebNotifier notifier,
                  Widget child,
                  ) =>
                  IndexedStack(
                    index: _notifier.currentIndex,
                    children: <Widget>[
                      const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF4C60FF)),
                        ),
                      ),
                      WebView(
//                    initialUrl: url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController controller) {
                          _webViewController = controller;
                          _webViewController.loadUrl(url, headers: {
                            'Referer': url,
                          });
                          if (html != null) {
                            _loadHtmlFromAsset();
                          }
                        },
                        javascriptChannels: _loadJavascriptChannel(context),
                        onPageStarted: (String url) {
//                  evaluateJavascript();

                          print("start:" + url);
                          notifier.checkConnected();
                        },
                        onPageFinished: (String url) {
                          print("finish:" + url);
                          if (notifier.isConnect) {
                            notifier.currentIndex = 1;
                          }
                          if (needReloadTitle) {
                            _loadTitle();
                          }
                        },
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url.startsWith('alipays:') ||
                              request.url.startsWith('weixin:')) {
                            _openPay(context, request.url);
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                      _buildWebViewFailWidget()
                    ],
                  ),
            ),
            ),)
          );
        }
    );
  }
  /// 获取当前加载页面的 title
  Future<void> _loadTitle() async {
    final String temp = await _webViewController.getTitle();
    print('title:' + temp);
    setState(() {
      title = temp;
    });
  }

  //从assert中加载网页
  Future<void> _loadHtmlFromAsset() async {
    final String path = await rootBundle.loadString(html);
    _webViewController.loadUrl(Uri.dataFromString(path,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  Future<void> evaluateJavascript() async {
    print('evaluateJavascript');

    _webViewController
        ?.evaluateJavascript('callJS(\'visible\');')
        ?.then((result) {
      print(result);
//      _webViewController.reload();
    });
  }
  //此处是设置js回调flutter
  Set<JavascriptChannel> _loadJavascriptChannel(BuildContext context) {
    final Set<JavascriptChannel> channels = Set<JavascriptChannel>();
    JavascriptChannel appChannel = JavascriptChannel(
        name: 'App',
        onMessageReceived: (JavascriptMessage message) {
//          Scaffold.of(context).showSnackBar(
//            SnackBar(content: Text(message.message)),
//          );
            if(message.message==WebViewPage.BACK_APP){
              FocusScope.of(context).unfocus();
              Navigator.maybePop(context);
            }

        });
    channels.add(appChannel);
    return channels;
  }

  Future<bool> _goBack(BuildContext context) async {
    print('_goBack');
    if (_webViewController != null && await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return false;
    }
    return true;
  }

  Widget _buildWebViewFailWidget() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Container(
              child: Image.asset(
                'assets/images/common_network_error.png',
                fit: BoxFit.fitWidth,
                width: 180,
              ),
            ),
          ),
          Text(
            '请检查你的网络设置',
            style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              width: 200,
              height: 45,
              child: FlatButton(
                color: const Color(0xFFFFFFFF),
                textColor: const Color(0xFF4C60FF),
                child: Text(
                  '重新加载',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.5),
                    side: const BorderSide(
                      color: Color(0xFF4C60FF),
                      width: 1,
                    )),
                onPressed: () => _onPressedReload(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPressedReload(BuildContext context) {
    if (_webViewController == null) {
      return;
    }
    _notifier.checkConnected();
    _webViewController.reload();
  }

  Future<void> _openPay(BuildContext context, String url) async {
    print('payurl:' + url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('未安装支付软件')),
      );
    }
  }

}
