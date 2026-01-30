import 'package:flutter/material.dart';
import 'package:notes/Services/authentication_services.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key, required this.logoutTitle});

  final String logoutTitle;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: BorderSide(width: 2, color: Theme.of(context).primaryColorDark),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              logoutTitle,
              style: TextStyle(
                fontFamily: "Serif",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
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
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "No",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Serif",
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColorDark,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  AuthServices.logout();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Serif",
                  ),
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
