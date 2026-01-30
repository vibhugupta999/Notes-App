import 'package:flutter/material.dart';
import 'package:notes/Data/Local/notedata.dart';
import 'package:notes/Provider/notecontrollerprovider.dart';
import 'package:notes/Provider/noteprovider.dart';
import 'package:notes/Screens/addnotescreen.dart';
import 'package:notes/Widgets/appbar.dart';
import 'package:notes/Widgets/logoutdialog.dart';
import 'package:notes/Widgets/notetile.dart';
import 'package:notes/Widgets/searchbar.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<NoteProvider>(context, listen: false).setNotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", Icons.logout, () {
        showDialog(
          context: context,
          builder: (context) =>
              LogOutDialog(logoutTitle: "Are you sure , you want to log out ?"),
        );
      }),
      body: Consumer<NoteProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          List<Note> note = value.notes;
          if (note.isEmpty && value.searchTerm.isEmpty) {
            return Expanded(
              child: Center(
                child: Text("No Notes Added yet!! \n Try Adding notes"),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                children: [
                  Searchbar(),
                  Expanded(
                    child: SizedBox(
                      child: note.isNotEmpty
                          ? ListView.builder(
                              itemCount: note.length,
                              itemBuilder: (context, index) {
                                return Notetile(
                                  index: index,
                                  note: note[index],
                                );
                              },
                            )
                          : Text("No note(s) for your search!!"),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => Notecontrollerprovider(),
                child: Addnotescreen(isnewNote: true),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }
}
