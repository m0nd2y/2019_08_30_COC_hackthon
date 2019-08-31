import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlemanage/ict/profile.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('user')
          .document('sj203904@naver.com')
          .collection('friends')
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
                  GestureDetector(
                    onTap: () {
                      _settingModalBottomSheet(
                          context,
                          snapshot.data.documents[i]['name'],
                          snapshot.data.documents[i]['location']);
                    },
                    child: Container(
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
                                    snapshot.data.documents[i]['name'],
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(snapshot.data.documents[i]['location']),
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet(context, name, location) {
    showModalBottomSheet(
      elevation: 10,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 1200,
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('lib/assets/profileicon.png', height: 170),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(50),
                width: 130,
                height: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  location,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 10),
                height: 1,
                width: MediaQuery.of(context).size.width - 60,
                color: Colors.grey,
              ),
              Container(
                height: 115,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 5.0),
                            child: Text(
                              '47분',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('Gyeonggi-do'),
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
                          child: Text('오후 6:46'),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32, right: 30),
                          height: 1,
                          width: 90,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 115,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 5.0),
                            child: Text(
                              '29분',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text('Gyeonggi-do'),
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
                          child: Text('오전 7:49'),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 32, right: 30),
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
        );
      },
    );
  }
}
