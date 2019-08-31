import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:circlemanage/circlepage/newtask.dart';

class CirclePage extends StatefulWidget {
  final String circlename;

  CirclePage({Key key, this.circlename}) : super(key: key);

  @override
  _CirclePageState createState() => _CirclePageState();
}

class _CirclePageState extends State<CirclePage>
    with SingleTickerProviderStateMixin {
  // Create a tab bar controller
  TabController controller;

  String _newtaskname;
  var _newtaskstat;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        elevation: 20.0,
        title: Text(
          widget.circlename,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Expanded(
        //       child: Text(
        //         widget.circlename,
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //     FlatButton(
        //       child: Icon(
        //         Icons.add_box,
        //         color: Colors.white,
        //       ),
        //       onPressed: () => {
        //             showDialog(
        //               context: context,
        //               builder: (BuildContext context) {
        //                 return NewTask(
        //                   circlename: widget.circlename,
        //                 );
        //               },
        //             ),
        //           },
        //     ),
        //   ],
        // ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          StreamBuilder(
            stream: Firestore.instance
                .collection('circles')
                .document(widget.circlename)
                .collection('task')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                itemExtent: 140.0,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => _buildListItem(
                    context, snapshot.data.documents[index], index),
              );
            },
          ),
          Positioned(
            bottom: 30.0,
            child: RaisedButton(
              elevation: 10,
              color: Colors.orangeAccent,
              shape: StadiumBorder(),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 80, right: 80),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    Text(
                      ' Add Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NewTask(
                      circlename: widget.circlename,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot document, var index) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          elevation: 20.0,
          highlightElevation: 5.0,
          padding: EdgeInsets.all(10.0),
          onPressed: () => {},
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    document['taskname'],
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _taskstat(
                      document, document['taskstat'], index) //<Widget>[
                  /*
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        'Prepare',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    onPressed: () => {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Proceed',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Text(
                          'Complete',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  */
                  //],
                  ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _taskstat(DocumentSnapshot document, var taskstat, var index) {
    List<Widget> list = [];

    if (taskstat == 0) {
      list.add(
        Flexible(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                'Prepare',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            onPressed: () => {},
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Proceed',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {
                    document.reference.updateData(
                      {
                        'taskstat': 1,
                      },
                    ),
                  },
            ),
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Complete',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {
                    document.reference.updateData(
                      {
                        'taskstat': 2,
                      },
                    ),
                  },
            ),
          ),
        ),
      );
    } else if (taskstat == 1) {
      list.add(
        Flexible(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                'Prepare',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            onPressed: () => {
                  document.reference.updateData(
                    {
                      'taskstat': 0,
                    },
                  ),
                },
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.orangeAccent,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Proceed',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {},
            ),
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Complete',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {
                    document.reference.updateData(
                      {
                        'taskstat': 2,
                      },
                    ),
                  },
            ),
          ),
        ),
      );
    } else if (taskstat == 2) {
      list.add(
        Flexible(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(
                'Prepare',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            onPressed: () => {
                  document.reference.updateData(
                    {
                      'taskstat': 0,
                    },
                  ),
                },
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Proceed',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {
                    document.reference.updateData(
                      {
                        'taskstat': 1,
                      },
                    ),
                  },
            ),
          ),
        ),
      );
      list.add(
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.lightGreen,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                  'Complete',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onPressed: () => {},
            ),
          ),
        ),
      );
    }

    return list;
  }
}
