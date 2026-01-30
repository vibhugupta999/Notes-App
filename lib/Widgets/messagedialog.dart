import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.font, required this.message});

  final String? font;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
          side: BorderSide(
            width: 1.2,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                message,
                style: TextStyle(
                  fontFamily: font,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
