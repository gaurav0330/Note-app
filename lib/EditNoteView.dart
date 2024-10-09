import 'package:flutter/material.dart';
import 'package:googlenoteclone/NoteView.dart';
import 'package:googlenoteclone/colors.dart';
import 'package:googlenoteclone/model/MyNoteModel.dart';
import 'package:googlenoteclone/services/db.dart';


class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitile;
  late String NewNoteDet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitile=widget.note.title.toString();
    this.NewNoteDet=widget.note.content.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async{
                Note newNote=Note(content:NewNoteDet,title: NewTitile ,createdTime: widget.note.createdTime,pin: widget.note.pin,id:widget.note.id, isArchive: widget.note.isArchive );
                await NotesDatabse.instance.updateNote(Note(content:NewNoteDet,title: NewTitile ,createdTime: widget.note.createdTime,pin: widget.note.pin,id:widget.note.id, isArchive: widget.note.isArchive ));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoteView(note: newNote),));

              },
              icon: Icon(Icons.save_outlined,color: white))
        ],
        iconTheme: IconThemeData(
          color: white, //change your color here
        ),
      ),

      body:
      Container(
        margin : EdgeInsets.symmetric(horizontal : 15 ,vertical: 10),
        child: Column(
          children: [
            Form(
                child:TextFormField(
                  onChanged: (value){
                    NewTitile=value;
                  },
                  initialValue: NewTitile,
                  cursorColor: white,
                  style: TextStyle(fontSize: 25, color: Colors.white , fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Enter Title",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),),
            //Content TextFiled
            Container(
              height: 300,
              child: Form(
                child: TextFormField(
                  initialValue: NewNoteDet,
                  onChanged: (value){
                    NewNoteDet=value;
                  },
                  cursorColor: white,
                  keyboardType:  TextInputType.multiline,
                  minLines: 50,
                  maxLines: null,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Enter Note",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),
              ),
            )

          ],
        ),),

    );
  }
}