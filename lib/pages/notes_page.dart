import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/services/firestore.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  final TextEditingController textController = TextEditingController();

  // open a dialog box to add a note
  void openNoteBox({String? docId, String? existingText}) {
    textController.text = existingText ?? '';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(docId == null ? 'Add Note' : 'Update Note'),
            // text user input
            content: Form(
              child: TextFormField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter your note here'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              // button to save
              ElevatedButton(
                onPressed: () {
                  // add a new note
                  final text = textController.text.trim();
                  if (docId == null) {
                    firestoreService.addNote(text);
                  } else {
                    firestoreService.updateNote(docId, text);
                  }

                  // clear the text controller
                  textController.clear();

                  // close the dialog box
                  Navigator.pop(context);
                },
                child: Text(docId == null ? 'Add' : 'Update'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          // if there is no data, return nothing
          if (!snapshot.hasData) {
            return const Text("No notes..");
          }

          // get all the docs
          List notesList = snapshot.data!.docs;

          // display as a list
          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              // get each individual doc
              DocumentSnapshot document = notesList[index];
              String docId = document.id;

              // get note from each doc
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String noteText = data['note'];

              // display as a list tile
              return ListTile(
                title: Text(noteText),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // update button
                    IconButton(
                      onPressed:
                          () =>
                              openNoteBox(docId: docId, existingText: noteText),
                      icon: const Icon(Icons.settings),
                    ),
                    // delete button
                    IconButton(
                      onPressed: () => firestoreService.deleteNote(docId),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
