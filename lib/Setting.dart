import 'package:flutter/material.dart';
import 'package:googlenoteclone/services/login_info.dart';
import '/colors.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value=false;

  getSyncSet() async{
  LocalDataSaver.getSyncSet().then((onValue)
  {
  setState(() {
    value=onValue!;
  });
  }
  );
  }

  @override
  void initState() {
    getSyncSet();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(backgroundColor: bgColor,
          elevation: 0.0,
          title : Text("Settings")
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Row(children: [
            Text("Sync" ,style: TextStyle(color: Colors.white , fontSize: 18),),
            Spacer(),
            Transform.scale(scale: 1.3,
              child : Switch.adaptive(value: value, onChanged: (switchValue) {
                setState(() {
                  this.value = switchValue;
                  LocalDataSaver.saveSyncSetting(switchValue);
                });
              }),)
          ],)
        ],),),
    );
  }
}