import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentsPage extends StatefulWidget {
  @override
  _RecentsPageState createState() => _RecentsPageState();
}

class _RecentsPageState extends State<RecentsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('user')
          .document('ldj6192@gmail.com')
          .collection('recent')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                for (var i = 0; i < snapshot.data.documents.length; i++)
                  Container(
                    height: 115,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Image.asset(
                            'lib/assets/profileicon.png',
                            height: 60,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 5.0),
                                child: Text(
                                  snapshot.data.documents[i]['ncalltime']
                                          .toString() +
                                      '분',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(snapshot.data.documents[i]['location']),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                height: 1,
                                width: MediaQuery.of(context).size.width - 100,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 55),
                              child: Text(snapshot.data.documents[i]['time']),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 37, right: 30),
                              height: 1,
                              width: 90,
                              color: Colors.grey,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
