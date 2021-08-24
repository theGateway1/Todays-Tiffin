import 'package:flutter/material.dart';
import 'package:z_todays_tiffin/Utilities/utilities.dart';
import 'package:z_todays_tiffin/services/firebase_methods.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({Key? key}) : super(key: key);

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  String approved = "Approved";
  String denied = "Denied";
  late Future<List<Map<dynamic, dynamic>>> _listFuture;
  Map<dynamic, dynamic> thisMap = {};
  List<Map<dynamic, dynamic>> finalRequestList = [{}];
  List<Map<dynamic, dynamic>> mapRequestList = [{}];

  Widget getText(String heading, String detail) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Column(
        children: [
          Row(children: [
            Text(
              "$heading: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SelectableText(
              "$detail ",
              enableInteractiveSelection: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<List<Map<dynamic, dynamic>>> getList() async {
    final reqList = await OtherServices().getRequestList();
    return reqList;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _listFuture = getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pending Requests'),
        ),
        body: FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: getList(),
          builder: (context, requestList) {
            if (requestList.hasData) {
              finalRequestList = requestList.data!;
              finalRequestList.forEach((element) {
                thisMap.addAll(element);
              });
              mapRequestList.add(thisMap);
              print(mapRequestList.toString());
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                            // height: 180,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            width: MediaQuery.of(context).size.width * 0.99,
                            child: Card(
                                color: Colors.orange[200],
                                elevation: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getText("Last Updated",
                                        mapRequestList[1]["Last Updated At"]),
                                    mapRequestList[1]["Cancellation"] != "null"
                                        ? getText(
                                            "Cancellation",
                                            mapRequestList[1]["Cancellation"] ==
                                                    "true"
                                                ? approved
                                                : denied)
                                        : Container(),
                                    mapRequestList[1]["Clear Dues"] != "null"
                                        ? getText(
                                            "Clear Dues",
                                            mapRequestList[1]["Clear Dues"] ==
                                                    "true"
                                                ? approved
                                                : denied)
                                        : Container(),
                                    mapRequestList[1]["Changed Timing"] !=
                                            "null"
                                        ? getText(
                                            "Changed Timing",
                                            mapRequestList[1]
                                                        ["Changed Timing"] ==
                                                    "true"
                                                ? approved
                                                : denied)
                                        : Container(),
                                  ],
                                ))),
                      ],
                    ),
                  );
                },
                itemCount: 1,
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
