import 'package:flutter/material.dart';
import 'package:nepal_bank/HomePage/MainDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Container(
        height: 230,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: 330,
              decoration: BoxDecoration(color: Colors.deepPurple[100]),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 3),
                  Text(
                    'Rishesh Rajkarnikar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'rishesh@rk.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      height: 300,
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: 250,
            decoration: BoxDecoration(color: Colors.deepPurple[100]),
            child: Text('hello'),
          ),
        ],
      ),
    ),
    Text('Payment'),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Nepal bank app'),
        backgroundColor: Colors.deepPurple[200],
      ),
      drawer: MainDrawer(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple[200],
        iconSize: 23,
        selectedItemColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
