
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/utils/gaps.dart';


class ProgressDialog {
  static bool _isShowing = false;

  ///展示
  static void showProgress(BuildContext context,
      {Widget child = const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours.app_main),)}) {
    if(!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        PopRoute(
          child: _Progress(
            child: child,
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

///Widget
class _Progress extends StatelessWidget {
  final Widget child;

  _Progress({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          ProgressDialog.dismiss(context);

          return;
        },
      child: Material(
          color: Colors.black26,

          child:  Center(
              child:Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white
                ),

                child:Column(
                  children: <Widget>[
                    child,
                    Gaps.vGap20,
                    Text(
                     "请等待...",
                      style: TextStyle(
                          fontSize: 10
                      ),
                    )
                  ],
                ),

              ))
      )
    );
  }
}
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
