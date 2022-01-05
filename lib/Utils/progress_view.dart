import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient/Utils/colorsandstyles.dart';

enum ProgressDialogType { Normal, Download }

bool _isShowing = false;
late BuildContext _context, _dismissingContext;
bool _barrierDismissible = true, _showLogs = false;

double _borderRadius = 8.0;
Color _backgroundColor = Colors.transparent;
Curve _insetAnimCurve = Curves.easeInOut;

Widget _progressWidget = const Center(
    child: CircularProgressIndicator(
  color: Color(0xff233E8B),
));

class ProgressView {
  late _Body _dialog;
  ProgressView(BuildContext context,
      {ProgressDialogType? type, bool? isDismissible, bool? showLogs}) {
    _context = context;
    _barrierDismissible = true;
    _showLogs = showLogs ?? false;
  }

  bool isShowing() {
    return _isShowing;
  }

  void dismiss() {
    if (_isShowing) {
      try {
        _isShowing = false;
        if (Navigator.of(_dismissingContext).canPop()) {
          Navigator.of(_dismissingContext).pop();
          if (_showLogs) debugPrint('ProgressDialog dismissed');
        } else {
          if (_showLogs) debugPrint('Cant pop ProgressDialog');
        }
      } catch (_) {}
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
    }
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop(true);
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    FocusManager.instance.primaryFocus!.unfocus();
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;
      if (_showLogs) debugPrint('ProgressDialog shown');
      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return Material(
            type: MaterialType.transparency,
            child: WillPopScope(
              onWillPop: () {
                return Future.value(_barrierDismissible);
              },
              child: Dialog(
                  backgroundColor: _backgroundColor,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: Duration(milliseconds: 100),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  child: _dialog),
            ),
          );
        },
      );
    } else {
      if (_showLogs) debugPrint("ProgressDialog already shown/showing");
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  _BodyState _dialog = _BodyState();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var padding = width / 3;

    return Container(
      margin: EdgeInsets.all(padding),
      child: _progressWidget,
    );
  }
}
