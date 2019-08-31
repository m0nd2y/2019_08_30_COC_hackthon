import 'package:flutter/material.dart';
import 'package:circlemanage/ict/tabs/recents.dart';
import 'package:circlemanage/ict/tabs/contacts.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var tabheight = 65.0;
  var index = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(tabheight), // here the desired height
        child: AppBar(
          elevation: 0,
          title: Container(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(tabheight),
            child: Container(
              height: tabheight,
              child: TabBar(
                controller: tabController,
                tabs: <Widget>[
                  Container(
                    height: tabheight,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: new Text(
                          '최근기록',
                          style: TextStyle(
                            color: tabController.index == 0
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: tabheight,
                    child: Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: new Text(
                          '연락처',
                          style: TextStyle(
                            color: tabController.index == 1
                                ? Theme.of(context).accentColor
                                : Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          RecentsPage(),
          ContactsPage(),
        ],
      ),
    );
  }
}
