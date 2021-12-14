
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomSubmissionDialog extends StatefulWidget {
  final String absenceType, email, dateTime;
  final TextEditingController notesController;
  static const Color primaryColor = Color(0xFF38A3A5);
  final dynamic function;

  CustomSubmissionDialog(this.absenceType, this.email, this.dateTime,
      this.notesController, this.function);

  @override
  _CustomSubmissionDialogState createState() => _CustomSubmissionDialogState();
}

class _CustomSubmissionDialogState extends State<CustomSubmissionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 40.0),
          margin: EdgeInsets.only(top: 35.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.absenceType,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        widget.email,
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Tanggal',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        widget.dateTime,
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.0),
                      CustomTextField('Catatan', TextInputType.text,
                          widget.notesController),
                    ]),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    int trackingType = 0;
                    if (widget.absenceType == 'Absen Masuk')
                      trackingType = 0;
                    else
                      trackingType = 1;
                    widget.function(trackingType);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 48.0)),
                    backgroundColor: MaterialStateProperty.all(
                        CustomSubmissionDialog.primaryColor),
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)))),
                  ),
                  child: Text(
                    'Kirim',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        Positioned(
          left: 5.0,
          right: 5.0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: Icon(
                  Icons.warning_rounded,
                  color: CustomSubmissionDialog.primaryColor,
                  size: 50.0,
                )),
          ),
        ),
      ],
    );
  }
}
