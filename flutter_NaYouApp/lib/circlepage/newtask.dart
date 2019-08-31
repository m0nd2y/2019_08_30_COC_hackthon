import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTask extends StatefulWidget {
  final String circlename;

  NewTask({Key key, this.circlename}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String _newtaskname;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Name',
                ),
                onSaved: (String value) {
                  _newtaskname = value;
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        'Prepare',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    onPressed: () => {
                      if (_formKey.currentState.validate())
                        {
                          _formKey.currentState.save(),
                          Firestore.instance
                              .collection('circles')
                              .document(widget.circlename)
                              .collection('task')
                              .document()
                              .setData(
                                  {'taskname': _newtaskname, 'taskstat': 0})
                        },
                      Navigator.pop(context),
                    },
                  ),
                  Padding(
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () => {
                        if (_formKey.currentState.validate())
                          {
                            _formKey.currentState.save(),
                            Firestore.instance
                                .collection('circles')
                                .document(widget.circlename)
                                .collection('task')
                                .document()
                                .setData(
                                    {'taskname': _newtaskname, 'taskstat': 1})
                          },
                        Navigator.pop(context),
                      },
                    ),
                  ),
                  Padding(
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () => {
                        if (_formKey.currentState.validate())
                          {
                            _formKey.currentState.save(),
                            Firestore.instance
                                .collection('circles')
                                .document(widget.circlename)
                                .collection('task')
                                .document()
                                .setData(
                                    {'taskname': _newtaskname, 'taskstat': 2})
                          },
                        Navigator.pop(context),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
