import 'package:flutter/material.dart';
import 'package:googlenoteclone/ArchiveView.dart';
import 'package:googlenoteclone/Setting.dart';
import 'package:googlenoteclone/colors.dart';
import 'package:googlenoteclone/home.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer( // use drawer widget
      child: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    "Google Keep",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              Divider(
                color: white.withOpacity(0.3),
              ),
              sectionOne(),
              Divider(
                color: white.withOpacity(0.2),
              ),
              SizedBox(height: 5,),
              sectionTwo(),
              Divider(
                color: white.withOpacity(0.2),
              ),
              SizedBox(height: 5,),
              sectionSetting(),
              Divider(
                color: white.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget sectionOne()
  {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(black.withOpacity(0.3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ))),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  size: 25,
                  color: white.withOpacity(0.7),
                ),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Notes",
                  style: TextStyle(
                      color: white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget sectionTwo()
  {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ))),
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => ArchiveView(),));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.archive_outlined,
                  size: 25,
                  color: white.withOpacity(0.7),
                ),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Archive",
                  style: TextStyle(
                      color: white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )
      ),
    );
  }

  Widget sectionSetting()
  {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
          style: ButtonStyle(

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ))),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Settings()));
          },
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 25,
                  color: white.withOpacity(0.7),
                ),
                SizedBox(
                  width: 27,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                      color: white.withOpacity(0.7), fontSize: 18),
                )
              ],
            ),
          )
      ),
    );
  }
}