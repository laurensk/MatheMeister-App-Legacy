import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathemeister/models/apiError.dart';

class AlertUtils {
  static showApiErrorAlert(BuildContext context, String title, String desc, String closeButtonText) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(desc),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(closeButtonText),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  static showUnknownErrorAlert(BuildContext context, ApiError apiError) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Fehler"),
          content: Text("Ein unbekannter Fehler ist aufgetreten. Versuche es später noch einmal.\n\n${apiError.errorCode}: ${apiError.errorDesc}"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
