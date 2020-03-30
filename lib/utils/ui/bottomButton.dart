import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButtonStd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _onClick() {
      Navigator.pop(context);
    }

    return BottomButton(
      onClick: _onClick,
      title: "Zurück",
      backgroundColor: Colors.white,
      textStyle: TextStyle(
        fontFamily: "Arial Rounded MT Bold",
        fontSize: 21,
        color: Color(0xff40a764),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Function onClick;

  BottomButton({this.title, this.backgroundColor, this.textStyle, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton(
          onPressed: () {
            onClick();
          },
          child: Container(
            child: Center(child: Text(title, style: textStyle)),
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                width: 2.00,
                color: backgroundColor,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2.00, 2.00),
                  color: Color(0xff000000).withOpacity(0.16),
                  blurRadius: 6,
                )
              ],
              borderRadius: BorderRadius.circular(30.00),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 55),
        )
      ],
    );
  }
}
