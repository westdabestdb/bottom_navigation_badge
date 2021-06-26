import 'package:flutter/material.dart';
import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = new TextEditingController();
  BottomNavigationBadge badger = new BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8);

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Text("Notifications")),
    BottomNavigationBarItem(icon: Icon(Icons.face), title: Text("Profile"))
  ];
  int? dropdownSelected = 0;

  int _current = 0;

  void _change(int index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bottom Navigation Badge"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
              children: <Widget>[
                Text("Navigation Item: "),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: items[dropdownSelected!].title,
                    items:items.map((BottomNavigationBarItem item) {
                      return new DropdownMenuItem(
                        value: items.indexOf(item),
                        child: item.title!,
                      );
                    }).toList(),
                    onChanged: (int? i){
                      setState(() {
                        dropdownSelected = i;
                      });
                    },
                  ),
                )
              ],
          ),
          Row(
            children: <Widget>[
              Text("Badge Content: "),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  child: Text("Add Badge"),
                  onPressed: (){
                    String s = _textEditingController.text;
                    setState(() {
                      items = badger.setBadge(items, s, dropdownSelected!) as List<BottomNavigationBarItem>;
                    });
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  child: Text("Remove"),
                  onPressed: (){
                    setState(() {
                      items = badger.removeBadge(items, dropdownSelected!) as List<BottomNavigationBarItem>;
                    });
                  },
                ),
              ),
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  child: Text("Remove All"),
                  onPressed: (){
                    setState(() {
                      items = badger.removeAll(items) as List<BottomNavigationBarItem>;
                    });
                  },
                ),
              )
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        onTap: _change,
        items: items,
      ),
    );
  }
}
