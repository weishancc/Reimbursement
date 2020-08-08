import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_app/Animation/FadeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_calculator/flutter_calculator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

void _addEvent() {
  print('text');
}

class _HomePageState extends State<HomePage> {
  String time = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String event = "Food";
  String loaner = "??";
  double amount = 0.0;
  Map<dynamic, dynamic> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: null,
        ),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: null,
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/images/user.png'),
                    fit: BoxFit.cover),
              ),
              child: Transform.translate(
                offset: Offset(15, -15),
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    shape: BoxShape.circle,
                    color: Colors.yellow[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home_bg.jpg'),
                fit: BoxFit.cover)),
        //child: Padding
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                1.5,
                Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: AnimatedOpacity(
                      opacity: 0.9,
                      duration: Duration(milliseconds: 50),
                      child: MaterialButton(
                        onPressed: () => {
                          // ShowModalBottomSheet
                          showModalBottomSheet(
                            backgroundColor: Colors.lightGreen[300],
                            context: context,
                            builder: (BuildContext context) {
                              // Use StatefulBuilder to refresh showModalBottomSheet, #notice: pass the state instead of old state
                              return StatefulBuilder(builder: (context, state) {
                                return Container(
                                  height: 330,
                                  color: Colors.white70,
                                  child: itemList(state),
                                );
                              });
                            },
                          )
                        },
                        child: Text(
                          "＋ Add Item",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 50,
              ),
              FadeAnimation(
                1.2,
                makeItem(image: 'assets/images/2.jpg', date: 17),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.3,
                makeItem(image: 'assets/images/3.jpg', date: 18),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.4,
                makeItem(image: 'assets/images/4.jpg', date: 19),
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1.5,
                makeItem(image: 'assets/images/5.png', date: 20),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeItem({image, date}) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 200,
          margin: EdgeInsets.only(right: 20),
          child: Column(
            children: <Widget>[
              Text(
                date.toString(),
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "SEP",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Bumbershoot 2019",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "19:00 PM",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget itemList(state) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Time',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add"),
                  ],
                ),
                onPressed: () async {
                  // Pop up DatePicker and set
                  var result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2012),
                    lastDate: DateTime(2021),
                  );
                  print(result);

                  // set State
                  state(() {
                    time = DateFormat('yyyy-MM-dd').format(result);
                  });
                },
              ),
            ),
          ],
        ),
        // Split line
        Divider(
          height: 16.0,
          thickness: 3,
          indent: 20,
          endIndent: 20,
          color: Colors.grey[800],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Event',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              event,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add"),
                  ],
                ),
                onPressed: () async {
                  //Show GridView
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: GridView.count(crossAxisCount: 2, children: [
                            gridList('Food', context),
                            gridList('Shopping', context),
                            gridList('Clothing', context),
                            gridList('Entertain', context),
                            gridList('Transportation', context),
                            gridList('Others', context),
                          ]),
                        ),
                      );
                    },
                  );

                  // set State
                  state(() {});
                },
              ),
            ),
          ],
        ),
        // Split line
        Divider(
          height: 16.0,
          thickness: 3,
          indent: 20,
          endIndent: 20,
          color: Colors.grey[800],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Loaner',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              loaner,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.add),
                    Text("Add"),
                  ],
                ),
                onPressed: () async {
                  // Retrieve the username on firebase
                  DatabaseReference cruiser =
                      FirebaseDatabase.instance.reference().child('Users');
                  cruiser.once().then((DataSnapshot snapshot) {
                    users = snapshot.value;
                  });

                  //Show ListView
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: double.maxFinite,
                          child: ListView(
                            children: List.generate(
                              users.length,
                              (index) => ListTile(
                                leading: Icon(Icons.person),
                                title: Text(users.keys.toList()[index]),
                                onTap: () {
                                  loaner = users.keys.toList()[index];
                                  Navigator.pop(context);
                                  print(loaner);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  // set State
                  state(() {});
                },
              ),
            ),
          ],
        ),
        // Split line
        Divider(
          height: 16.0,
          thickness: 3,
          indent: 20,
          endIndent: 20,
          color: Colors.grey[800],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Amount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              amount.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: MaterialButton(
                padding: EdgeInsets.all(6.0),
                child: Column(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[Icon(Icons.add), Text("Add")],
                ),
                onPressed: () async {
                  // Pop up Calculator and set
                  var result = await showCalculator(
                    context: context,
                  );
                  print(result);

                  // set State
                  state(() {
                    amount = result;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.grey, Colors.blueGrey],
            ),
          ),
          child: MaterialButton(
            padding: EdgeInsets.all(10.0),
            onPressed: () => {
              Navigator.pop(context),
            },
            child: Text(
              "Add",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )),
      ],
    );
  }

  Widget gridList(String category, BuildContext context) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage('assets/images/$category.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
              Colors.transparent.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: MaterialButton(
          child: Text(
            category,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            event = category;
            Navigator.pop(context);
            print(event);
          },
        ),
      ),
    );
  }
}
