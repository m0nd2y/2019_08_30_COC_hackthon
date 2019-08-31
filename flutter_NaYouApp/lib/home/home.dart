import 'package:flutter/material.dart';
import 'package:circlemanage/resource/dimen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:circlemanage/circlepage/viewcircle.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int circlenum = 0;
  String _useruid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      /*
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Center(
            child: Text(
              'Circles You\'re In',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        */
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Your Circles',
                style: TextStyle(color: Colors.black),
              ),
              background: Container(
                color: Colors.white,
              ),
            ),
          ),
          SliverFillRemaining(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(widget.user.uid)
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
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: <Widget>[
                        /*
                                  if (snapshot
                                          .data
                                          .documents[widget.user.uid]['circlenames']
                                          .length ==
                                      0)
                                    Text('No circles to display...!!')
                                  else

                                      )
                                      */
                        for (var i = 0;
                            i < snapshot.data['circlenames'].length;
                            i++)
                          Container(
                            height: 180,
                            width: 150,
                            child: RaisedButton(
                              elevation: 15.0,
                              highlightElevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: Colors.white,
                              child: Text(
                                snapshot.data['circlenames'][i],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CirclePage(
                                          circlename:
                                              snapshot.data['circlenames'][i],
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

/*
  List<Widget> circle() {
    List<Widget> list = [];
    List circlenames = [];
    int a;

    Firestore.instance
        .collection('Test')
        .document('g75zuQgGvbXyeJ7UB9ax')
        .get()
        .then((DocumentSnapshot ds) {
      print('Got Document!!');
      a = ds.data["circles"];
      for (int i = 0; i < ds.data["circlenames"].length; i++) {
        circlenames.add(ds.data['circlenames'][i]);
      }

      for (int i = 0; i < circlenames.length; i++) {
        list.add(Container(
          height: 180,
          width: 150,
          child: RaisedButton(
            elevation: Dimen.elevation,
            highlightElevation: Dimen.highlightelevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.blue,
            child: Text(circlenames[i]),
            onPressed: () {},
          ),
        ));
      }

      //list.add(Text())

      return list;
    });
  }

  Widget circles() {
    circlenum++;

    return Container(
      height: 180,
      width: 150,
      child: RaisedButton(
        elevation: Dimen.elevation,
        highlightElevation: Dimen.highlightelevation,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: Colors.blue,
        child: Text("Circle" + circlenum.toString()),
        onPressed: () {},
      ),
    );
  }
  */
}
