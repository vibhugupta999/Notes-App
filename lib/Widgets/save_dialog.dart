import 'package:flutter/material.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key, required this.font,required this.dialogTitle});

  final String? font;
  final String dialogTitle;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: BorderSide(width: 1.2, color: Theme.of(context).primaryColorDark),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Text(
            dialogTitle,
            style: TextStyle(
              fontFamily: font,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  "Yes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
