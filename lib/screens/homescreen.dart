import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Widget textifyHeading(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 27, fontWeight: FontWeight.bold, fontFamily: 'Eraser'),
  );
}

Widget textifyMenuItem(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontFamily: 'Eraser',
    ),
    overflow: TextOverflow.clip,
    softWrap: false,
  );
}

Widget menuItem(String text, BuildContext context) {
  return Container(
    child: Row(
      children: [
        Icon(
          Icons.circle_outlined,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.059,
        ),
        textifyMenuItem(text),
        SizedBox(
          height: 45,
        ),
      ],
    ),
  );
}

Widget dividerHere() {
  return Text(
    '──────────────────────────────────────────────────',
    style: TextStyle(
        fontSize: 24, color: Colors.grey[400], fontWeight: FontWeight.bold),
    overflow: TextOverflow.clip,
    softWrap: false,
  );
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.42,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: textifyHeading('Today\'s Menu'),
                ),
              ),
              // dividerHere(),
              Container(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    color: Colors.black),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(20, 20, 15, 15),
                  children: [
                    //Menu Items Here
                    menuItem('Rajma', context),
                    menuItem('Chawal', context),
                    menuItem('Bhindi ki Bhujia', context),
                    menuItem('Roti', context),
                    menuItem('Raita', context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
