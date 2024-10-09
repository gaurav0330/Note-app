import 'package:googlenoteclone/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlenoteclone/login.dart';
import 'package:googlenoteclone/model/MyNoteModel.dart';
import 'package:googlenoteclone/services/auth.dart';
import 'package:googlenoteclone/services/db.dart';
import 'package:googlenoteclone/services/login_info.dart';
import 'package:googlenoteclone/sidemenubar.dart';
import 'SearchPage.dart';
import 'NoteView.dart';
import 'CreateNoteView.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String? ImgUrl = "";
  bool isLoading = true;
  List<Note> notesList = [];
  List<Note> notesPinList = [];
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool isStaggred =true;

  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  String note1 = "THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
    pinNotes();
  }
  Future createEntry(Note note) async {
    await NotesDatabse.instance.InsertEntry(note);
  }

  Future getAllNotes() async {
    LocalDataSaver.getImg().then((value) {
      if (this.mounted) {
        setState(() {
          ImgUrl = value;
        });
      }
    });
    this.notesList = await NotesDatabse.instance.readAllNotes();
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getOneNote(int id) async {
    await NotesDatabse.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabse.instance.updateNote(note);
  }

  Future deleteNote(Note note) async {
    await NotesDatabse.instance.delteNote(note);
  }

  Future deleteALLNote() async {
    await NotesDatabse.instance.deleteAllNotes();
  }

  Future<void> pinNotes() async {
    this.notesPinList = await NotesDatabse.instance.readPinnedNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: Icon(
                Icons.add,
                size: 40,
                color: white,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: SideMenu(),
            backgroundColor: bgColor,
            body: RefreshIndicator(
              onRefresh: ()  {
                return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      setState(() {
                      });
                    });
              },
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3)
                              ]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          _drawerKey.currentState!.openDrawer();
                                        },
                                        icon: Icon(
                                          Icons.menu,
                                          color: white,
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchView()));
                                      },
                                      child: Container(
                                          height: 55,
                                          width: 150,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Search Your Notes",
                                                  style: TextStyle(
                                                      color:
                                                          white.withOpacity(0.5),
                                                      fontSize: 16),
                                                )
                                              ])),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          style: ButtonStyle(
                                              overlayColor:
                                                  MaterialStateColor.resolveWith(
                                                      (states) =>
                                                          white.withOpacity(0.1)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ))),
                                          onPressed: () {
                                            setState(() {
                                              isStaggred=!isStaggred;
                                            });
                                          },
                                          child: Icon(
                                            Icons.grid_view,
                                            color: white,
                                          )),
                                      SizedBox(
                                        width: 9,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          signOut();
                                          LocalDataSaver.saveLoginData(false);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                                        },
                                        child: CircleAvatar(
                                          onBackgroundImageError:
                                              (Object, StackTrace) {
                                            print("Ok");
                                          },
                                          radius: 16,
                                          backgroundImage:
                                              NetworkImage(ImgUrl.toString()),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                      NoteSectionPin(),
                     isStaggred ?  NoteSectionAll() :
                      NotesListSection()
                    ],
                  ),
                ),
              )),
            ));
  }

  Widget NoteSectionAll() {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ALL",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notesList.length,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteView(
                                      note: notesList[index],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: white.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notesList[index].title,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              notesList[index].content.length > 250
                                  ? "${notesList[index].content.substring(0, 250)}..."
                                  : notesList[index].content,
                              style: TextStyle(color: white),
                            )
                          ],
                        ),
                      ),
                    ))),
      ],
    ));
  }

  Widget NoteSectionPin() {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Pined",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notesPinList.length,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteView(
                                      note: notesPinList[index],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: white.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notesPinList[index].title,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              notesPinList[index].content.length > 250
                                  ? "${notesPinList[index].content.substring(0, 250)}..."
                                  : notesPinList[index].content,
                              style: TextStyle(color: white),
                            )
                          ],
                        ),
                      ),
                    ))),
      ],
    ));
  }

  Widget NotesListSection() {
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "All",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteView(
                            note: notesList[index],
                          )));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notesList[index].title,
                          style: TextStyle(
                              color: white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(notesList[index].content.length > 250
                                ? "${notesList[index].content.substring(0, 250)}..."
                                : notesList[index].content,
                        style: TextStyle(color: white),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    ));
  }
}
