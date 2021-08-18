import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:z_todays_tiffin/constants/strings.dart';
import 'package:z_todays_tiffin/models/menu_item.dart';
import 'package:z_todays_tiffin/screens/support_screen.dart';
import 'package:http/http.dart' as http;

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

Widget normalScreenText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'Eraser',
    ),
    overflow: TextOverflow.clip,
    softWrap: false,
  );
}

Widget menuItem(String text, BuildContext context) {
  return text != "null"
      ? Container(
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
        )
      : Container();
}

Widget returnSizedBox(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.025,
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

MaterialStateProperty<EdgeInsetsGeometry> rpadding(BuildContext context) {
  return MaterialStateProperty.resolveWith((states) => EdgeInsets.fromLTRB(
      MediaQuery.of(context).size.width * 0.04,
      20,
      MediaQuery.of(context).size.width * 0.04,
      20));
}

MaterialStateProperty<Size> rsize(BuildContext context) {
  return MaterialStateProperty.resolveWith(
      (states) => Size.fromWidth(MediaQuery.of(context).size.width * 0.86));
}

class _HomeScreenState extends State<HomeScreen> {
  List<Menu> menus = [];
  String updated = "00:00";
  @override
  void initState() {
    // TODO: implement initState
    _retreiveMenus();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  void _retreiveMenus() async {
    menus = [];
    updated = "00:00";
    var response = await http.get(Uri.parse(BASE_URL));
    List res = json.decode(response.body);
    print(res.toString());
    res.forEach((element) {
      menus.add(Menu.fromMap(element));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontSize: 24, fontFamily: 'Eraser'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SupportScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.support,
              size: 27,
            ),
            padding: EdgeInsets.only(right: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              size: 27,
            ),
            padding: EdgeInsets.only(right: 10),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            6, MediaQuery.of(context).size.height * 0.01, 6, 0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.91,
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.height * 0.008,
            MediaQuery.of(context).size.width * 0.04,
            0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.02,
                      0,
                      MediaQuery.of(context).size.height * 0.02),
                  child: textifyHeading('Today\'s Menu'),
                ),
              ),
              // dividerHere(),
              Container(
                // color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.02,
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.015),
                  children: [
                    //Menu Items Here
                    menuItem(menus.first.i1, context),
                    menuItem(menus.first.i2, context),
                    menuItem(menus.first.i3, context),
                    menuItem(menus.first.i4, context),
                    menuItem(menus.first.i5, context),
                    menuItem(menus.first.i6, context),
                    menuItem(menus.first.i7, context),
                    menuItem(menus.first.i8, context),
                  ],
                ),
              ),
              returnSizedBox(context),
              Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04,
                    MediaQuery.of(context).size.height * 0.02,
                    0,
                    MediaQuery.of(context).size.height * 0.02),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  color: Colors.blue[200],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          menus.first.updated,
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          'ETA: 01:30 PM',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              returnSizedBox(context),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.red[800]),
                  padding: rpadding(context),
                  fixedSize: rsize(context),
                ),
                child: Text(
                  'Request Cancellation',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              returnSizedBox(context),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green[900]),
                  padding: rpadding(context),
                  fixedSize: rsize(context),
                ),
                child: Text(
                  'Request Changed Timing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              returnSizedBox(context),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.orange[600]),
                  padding: rpadding(context),
                  fixedSize: rsize(context),
                ),
                child: Text(
                  'Request Clear Dues',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
