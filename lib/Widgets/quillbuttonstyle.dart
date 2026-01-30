import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

QuillToolbarToggleStyleButtonOptions quillToggleButtonStyle(IconData icon) {
  return QuillToolbarToggleStyleButtonOptions(
    iconData: icon,
    iconSize: 16,
    iconTheme: QuillIconTheme(
      iconButtonUnselectedData: IconButtonData(color: Colors.black),
      iconButtonSelectedData: IconButtonData(color: Colors.white),
    ),
  );
}

QuillToolbarColorButtonOptions quillColorButtonStyle(IconData icon) {
  return QuillToolbarColorButtonOptions(
    iconData: icon,
    iconSize: 16,
    iconTheme: QuillIconTheme(
      iconButtonUnselectedData: IconButtonData(color: Colors.black),
    ),
  );
}
