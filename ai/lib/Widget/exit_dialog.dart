import "package:flutter/material.dart";

Future<bool> _onBackButtonPressed(BuildContext context) async {
  bool? exitapp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          content: Text("Do you want to quit"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
                child: Text("No",style: TextStyle(
                color: Colors.black,
              ),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Yes",style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        );
      });

  return exitapp ?? false;
}
