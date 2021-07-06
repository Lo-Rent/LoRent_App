import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lo_rent/constants.dart';

class FileCardWidget extends StatelessWidget {
  FileCardWidget({
    this.platformFile,
    this.onLongPress,
  });

  final PlatformFile platformFile;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        padding: EdgeInsets.only(top: 20, bottom: 14, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: kAccentColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5)),
            ],
            border: Border.all(color: kAccentColor.withOpacity(0.05))),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 4,
              width: MediaQuery.of(context).size.width / 5,
              color: Colors.blueGrey[100],
              child: (platformFile.extension == 'jpg' ||
                      platformFile.extension == 'png')
                  ? Image.file(
                      File(platformFile.path),
                      fit: BoxFit.contain,
                    )
                  : (platformFile.extension == 'mp4')
                      ? Icon(Icons.play_circle_fill_outlined)
                      : Icon(Icons.description_outlined),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    platformFile.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    '${(platformFile.size / 1000.0).round()} kb',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
