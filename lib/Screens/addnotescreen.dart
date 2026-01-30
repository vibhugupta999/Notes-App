import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/Provider/notecontrollerprovider.dart';
import 'package:notes/Widgets/notetoolbar.dart';
import 'package:notes/Widgets/save_dialog.dart';
import 'package:provider/provider.dart';

class Addnotescreen extends StatefulWidget {
  const Addnotescreen({super.key, required this.isnewNote});
  final bool isnewNote;

  @override
  State<Addnotescreen> createState() => _AddnotescreenState();
}

class _AddnotescreenState extends State<Addnotescreen> {
  late final QuillController quillController;
  late final TextEditingController titleController;
  late final FocusNode focusNode;

  late final Notecontrollerprovider notecontrollerprovider;

  @override
  void initState() {
    super.initState();
    notecontrollerprovider = context.read<Notecontrollerprovider>();
    titleController = TextEditingController(text: notecontrollerprovider.title);
    quillController = QuillController.basic()
      ..addListener(() {
        notecontrollerprovider.desc = quillController.document;
      });
    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isnewNote) {
        focusNode.requestFocus();
        notecontrollerprovider.readOnly = false;
      } else {
        notecontrollerprovider.readOnly = true;
        quillController.document = notecontrollerprovider.desc;
      }
    });
    focusNode.canRequestFocus = widget.isnewNote;
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme.titleLarge!.fontFamily;
    var popScope = PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (!notecontrollerprovider.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSaveNote = await showDialog<bool?>(
          context: context,
          builder: (context) {
            return SaveDialog(
              font: font,
              dialogTitle: "Do you want to save the note",
            );
          },
        );

        if (shouldSaveNote == null) return;

        if (!context.mounted) return;

        if (shouldSaveNote) {
          notecontrollerprovider.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.isnewNote ? "Add note" : "Edit note",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            Selector<Notecontrollerprovider, bool>(
              selector: (_, notecontrollerprovider) =>
                  notecontrollerprovider.canSaveNote,
              builder: (_, canSaveNote, __) => IconButton(
                onPressed: canSaveNote
                    ? () {
                        notecontrollerprovider.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
                disabledColor: Theme.of(context).disabledColor,
                color: Theme.of(context).textTheme.headlineMedium!.color,
                icon: FaIcon(FontAwesomeIcons.check, size: 28),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Column(
            children: [
              if (!widget.isnewNote) ...[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Date Edited",
                          style: TextStyle(fontFamily: font),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          DateFormat("dd MMMM y , hh:mm a").format(
                            DateTime.fromMillisecondsSinceEpoch(
                              notecontrollerprovider.note!.dateEdited,
                            ),
                          ),
                          style: TextStyle(fontFamily: font),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Selector<Notecontrollerprovider, bool>(
                          selector: (context, notecontrollerprovider) =>
                              notecontrollerprovider.readOnly,
                          builder: (context, readOnly, child) => IconButton(
                            onPressed: () {
                              setState(() {
                                notecontrollerprovider.readOnly = !readOnly;
                                if (notecontrollerprovider.readOnly) {
                                  FocusScope.of(context).unfocus();
                                  focusNode.canRequestFocus = false;
                                } else {
                                  focusNode.canRequestFocus = true;
                                  focusNode.requestFocus();
                                }
                              });
                            },
                            icon: !readOnly
                                ? Icon(Icons.remove_red_eye)
                                : FaIcon(FontAwesomeIcons.pen, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Selector<Notecontrollerprovider, bool>(
                  selector: (context, notecontrollerprovider) =>
                      notecontrollerprovider.readOnly,
                  builder: (context, readOnly, child) => TextField(
                    controller: titleController,
                    style: TextStyle(
                      fontFamily: font,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: " Title",
                      hintStyle: TextStyle(
                        color: Color(0xff8898a7),
                        fontFamily: font,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    canRequestFocus: !readOnly,
                    onChanged: (value) {
                      notecontrollerprovider.title = value;
                    },
                  ),
                ),
              ),

              Expanded(
                child: Selector<Notecontrollerprovider, bool>(
                  selector: (_, notecontrollerprovider) =>
                      notecontrollerprovider.readOnly,
                  builder: (_, read, __) => Column(
                    children: [
                      SizedBox(height: 25),
                      Expanded(
                        child: QuillEditor.basic(
                          controller: quillController,
                          focusNode: focusNode,
                          config: QuillEditorConfig(
                            expands: true,
                            placeholder: "Write your notes here!!",
                          ),
                        ),
                      ),
                      if (!read)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColorDark,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColorDark,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: NoteToolBar(quillController: quillController),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return popScope;
  }
}
