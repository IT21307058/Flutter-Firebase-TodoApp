import 'package:firebase_web_app/Custom/TodoCard.dart';
import 'package:firebase_web_app/Service/Auth_Service.dart';
import 'package:firebase_web_app/pages/AddTodo.dart';
import 'package:firebase_web_app/pages/SignUpPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthClass authClass = AuthClass();
    int _currentIndex = 0;

    final List<Widget> _pages = [
      HomePage(),
      AddTodoPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black, items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 32,
            color: Colors.white,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              // Navigate to the AddTodoPage when the "Add" tab is tapped
              setState(() {
                _currentIndex = 1; // Assuming the AddTodoPage is at index 1
              });
            },
            child: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.purple],
                  )),
              child: Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32,
            color: Colors.white,
          ),
          label: "Settings",
        ),
      ]),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                TodoCard(
                  title: "Wake up bro",
                  check: true,
                  iconBGColor: Colors.white,
                  iconColor: Colors.red,
                  iconData: Icons.alarm,
                  time: "10 AM",
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () async {
//                 await authClass.logout();
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (builder) => SignUpPage()),
//                     (route) => false);
//               }),
