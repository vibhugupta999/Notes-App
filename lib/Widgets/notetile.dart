import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/Data/Local/notedata.dart';
import 'package:notes/Provider/notecontrollerprovider.dart';
import 'package:notes/Provider/noteprovider.dart';
import 'package:notes/Screens/addnotescreen.dart';
import 'package:notes/Widgets/save_dialog.dart';
import 'package:provider/provider.dart';

class Notetile extends StatelessWidget {
  final int index;
  final Note note;
  const Notetile({super.key, required this.index, required this.note});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme.titleLarge!.fontFamily;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => Notecontrollerprovider()..note = note,
              child: Addnotescreen(isnewNote: false),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(color: Color.fromARGB(255, 255, 225, 0)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark,
              offset: Offset(2, 2),
              blurRadius: 1.5,
            ),
          ],
        ),

        child: ListTile(
          title: note.title != null
              ? Text(
                  note.title!,
                  style: TextStyle(
                    color: Color(0xff34383b),
                    fontSize: 18,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(""),
          subtitle: note.description != null
              ? Text(
                  note.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xff8495a4),
                    fontSize: 16,
                    fontFamily: "Serif",
                  ),
                )
              : Text(""),
          trailing: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    DateFormat("d MMM, y").format(
                      DateTime.fromMillisecondsSinceEpoch(note.dateEdited),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () async {
                      final shoulddeleteNote =
                          await showDialog<bool?>(
                            context: context,
                            builder: (context) {
                              return SaveDialog(
                                font: font,
                                dialogTitle: "Do you want to delete the note",
                              );
                            },
                          ) ??
                          false;
                      if (shoulddeleteNote && context.mounted) {
                        context.read<NoteProvider>().deleteNote(note);
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.redAccent.shade400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
