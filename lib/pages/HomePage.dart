import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_web_app/Custom/TodoCard.dart';
import 'package:firebase_web_app/Service/Auth_Service.dart';
import 'package:firebase_web_app/pages/AddTodo.dart';
import 'package:firebase_web_app/pages/SignUpPage.dart';
import 'package:firebase_web_app/pages/view_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => AddTodoPage()));
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
      body: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;

                switch (document["Category"]) {
                  case "Food":
                    iconData = Icons.local_grocery_store;
                    iconColor = Colors.blue;
                    break;
                  case "Workout":
                    iconData = Icons.alarm;
                    iconColor = Colors.teal;
                    break;
                  case "Work":
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.red;
                    break;
                  case "Run":
                    iconData = Icons.audiotrack;
                    iconColor = Colors.green;
                    break;
                  default:
                    iconData = Icons.run_circle_outlined;
                    iconColor = Colors.white;
                }

                return InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewData(
                          document: document,
                          id: snapshot.data!.docs[index].id,
                        ),
                      ),
                    ),
                  },
                  child: TodoCard(
                    title: document["title"] == null
                        ? "Hey There"
                        : document["title"],
                    check: true,
                    iconBGColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                    time: "10 AM",
                  ),
                );
              },
            );
          }),
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
