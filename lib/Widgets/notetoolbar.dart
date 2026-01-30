import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/Widgets/quillbuttonstyle.dart';

class NoteToolBar extends StatelessWidget {
  const NoteToolBar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return QuillSimpleToolbar(
      controller: quillController,
      config: QuillSimpleToolbarConfig(
        multiRowsDisplay: false,
        showFontFamily: false,
        showFontSize: false,
        showSubscript: false,
        showSuperscript: false,
        showSmallButton: false,
        showInlineCode: false,
        showAlignmentButtons: false,
        showDirection: false,
        showDividers: false,
        showHeaderStyle: false,
        showListCheck: false,
        showCodeBlock: false,
        showQuote: false,
        showIndent: false,
        showLink: false,
        buttonOptions: QuillSimpleToolbarButtonOptions(
          undoHistory: QuillToolbarHistoryButtonOptions(
            iconSize: 16,
            iconData: FontAwesomeIcons.arrowRotateLeft,
            iconTheme: QuillIconTheme(
              iconButtonUnselectedData: IconButtonData(
                color: Colors.black,
              ),
            ),
          ),
          redoHistory: QuillToolbarHistoryButtonOptions(
            iconSize: 16,
            iconData: FontAwesomeIcons.arrowRotateRight,
            iconTheme: QuillIconTheme(
              iconButtonUnselectedData: IconButtonData(
                color: Colors.black,
              ),
            ),
          ),
          bold: quillToggleButtonStyle(FontAwesomeIcons.bold),
          italic: quillToggleButtonStyle(
            FontAwesomeIcons.italic,
          ),
          underLine: quillToggleButtonStyle(
            FontAwesomeIcons.underline,
          ),
          strikeThrough: quillToggleButtonStyle(
            FontAwesomeIcons.strikethrough,
          ),
          color: quillColorButtonStyle(
            FontAwesomeIcons.palette,
          ),
          backgroundColor: quillColorButtonStyle(
            FontAwesomeIcons.fillDrip,
          ),
          clearFormat: QuillToolbarClearFormatButtonOptions(
            iconData: FontAwesomeIcons.textSlash,
            iconSize: 16,
            iconTheme: QuillIconTheme(
              iconButtonUnselectedData: IconButtonData(
                color: Colors.black,
              ),
            ),
          ),
          listNumbers: quillToggleButtonStyle(
            FontAwesomeIcons.listOl,
          ),
          listBullets: quillToggleButtonStyle(
            FontAwesomeIcons.listUl,
          ),
          search: QuillToolbarSearchButtonOptions(
            iconData: FontAwesomeIcons.magnifyingGlass,
            iconSize: 16,
            iconTheme: QuillIconTheme(
              iconButtonUnselectedData: IconButtonData(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
