import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SupportScreen extends StatelessWidget {
  MaterialStateProperty<EdgeInsetsGeometry> rpadding(BuildContext context) {
    return MaterialStateProperty.resolveWith((states) => EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.04,
        20,
        MediaQuery.of(context).size.width * 0.04,
        20));
  }

  MaterialStateProperty<Size> rsize(BuildContext context) {
    return MaterialStateProperty.resolveWith(
        (states) => Size.fromWidth(MediaQuery.of(context).size.width * 0.46));
  }

  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Support',
          style: TextStyle(fontSize: 24, fontFamily: 'Eraser'),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.24,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SelectableText(
              'We would love to answer all your queries. \n \n Call: +91 78778 98892',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.red),
              padding: rpadding(context),
              fixedSize: rsize(context),
            ),
            onPressed: () => UrlLauncher.launch('tel: +91 7877898892'),
            icon: Icon(Icons.call),
            label: Text(
              'Call Now',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
