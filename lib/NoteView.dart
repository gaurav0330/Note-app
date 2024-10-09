import 'package:flutter/material.dart';
import 'package:googlenoteclone/ArchiveView.dart';
import 'package:googlenoteclone/EditNoteView.dart';
import 'package:googlenoteclone/colors.dart';
import 'package:googlenoteclone/home.dart';
import 'package:googlenoteclone/services/db.dart';
import 'package:intl/intl.dart';
import 'model/MyNoteModel.dart';
class NoteView extends StatefulWidget {
  Note note;
   NoteView({required this.note});

  @override
  _NoteViewState createState() => _NoteViewState();
}


class _NoteViewState extends State<NoteView> {
  @override

  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white, //change your color here
        ),
        title: Text("Edit ",style: TextStyle(color: white),),
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async{
                await NotesDatabse.instance.pinNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
              },
              icon: widget.note.pin ? Icon(Icons.push_pin,color: white,):Icon(Icons.push_pin_outlined,color: white,)),
          IconButton(
              splashRadius: 17,
              onPressed: () async{
                await NotesDatabse.instance.archiveNote(widget.note);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ArchiveView(),));
              },
              icon: widget.note.isArchive ? Icon(Icons.archive,color: white,):Icon(Icons.archive_outlined,color: white,)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteView(note: widget.note)));
              },
              icon: Icon(Icons.edit_outlined,color: white)),
           IconButton(
              splashRadius: 17,
              onPressed: () async{
                await NotesDatabse.instance.delteNote(widget.note);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Home() ));
              },
              icon: Icon(Icons.delete_forever_outlined,color: white)),
        ],
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text("Created On : ${DateFormat('dd-MM-yyyy - kk:mm').format(widget.note.createdTime)} ", style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(widget.note.title , style: TextStyle(color: Colors.white , fontSize: 23 , fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(widget.note.content,style: TextStyle(color: Colors.white),)
              ]
          ),
        ),
      ),
    );
  }
}