import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:googlenoteclone/NoteView.dart';
import 'package:googlenoteclone/colors.dart';
import 'package:googlenoteclone/model/MyNoteModel.dart';
import 'package:googlenoteclone/sidemenubar.dart';
import 'services/db.dart';
import 'CreateNoteView.dart';

class ArchiveView extends StatefulWidget {
  @override
  _ArchiveViewState createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool isLoading = true;
  List<Note> archivedList = [];

  Future<void> archivedNotes() async {
    this.archivedList = await NotesDatabse.instance.readArchivedNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    archivedNotes();
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateNoteView()),
          );
        },
        backgroundColor: cardColor,
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      endDrawerEnableOpenDragGesture: true,
      key: _drawerKey,
      drawer: SideMenu(),
      backgroundColor: bgColor,
      body: SafeArea(
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
                        blurRadius: 3,
                      ),
                    ],
                  ),
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
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 55,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Search Your Notes",
                                  style: TextStyle(
                                    color: white.withOpacity(0.5),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.grid_view,
                                color: white,
                              ),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                NoteSectionAll(),
              ],
            ),
          ),
        ),
      ),
    );
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
                  "ARCHIVED",
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
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
              itemCount: archivedList.length,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteView(note: archivedList[index]),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        archivedList[index].title,
                        style: TextStyle(
                          color: white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        archivedList[index].content.length > 250
                            ? "${archivedList[index].content.substring(0, 250)}..."
                            : archivedList[index].content,
                        style: TextStyle(color: white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
