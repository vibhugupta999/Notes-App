import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes/Provider/noteprovider.dart';
import 'package:provider/provider.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  late final TextEditingController searchController;
  late final NoteProvider noteProvider;

  @override
  void initState() {
    super.initState();
    noteProvider = context.read();
    searchController = TextEditingController()
      ..addListener(() {
        noteProvider.searchTerm = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff0f2f5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search notes",
          hintStyle: TextStyle(
            color: Color(0xff8494a5),
            fontSize: 18,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
          ),
          prefixIcon: Icon(Icons.search, size: 26, color: Color(0xff8494a5)),
          suffixIcon: ListenableBuilder(
            listenable: searchController,
            builder: (context, child) =>
                searchController.text.isNotEmpty ? child! : SizedBox.shrink(),
            child: GestureDetector(
              onTap: () {
                searchController.clear();
              },
              child: Icon(
                FontAwesomeIcons.circleXmark,
                color: Color.fromARGB(255, 82, 92, 103),
              ),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xfff0f2f5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xfff0f2f5)),
          ),
        ),
        onChanged: (value) {
          context.read<NoteProvider>().searchTerm = value;
        },
      ),
    );
  }
}
