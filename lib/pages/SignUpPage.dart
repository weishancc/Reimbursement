import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookkeeping_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bookkeeping_app/Animation/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  // Variable Declaration scope
  AnimationController _animationController;
  Animation<double> _animation;
  bool _textVisible = true;
  final TextEditingController nameCtr = new TextEditingController();
  final TextEditingController passwordCtr = new TextEditingController();
  DatabaseReference cruiser = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation =
        Tween<double>(begin: 1.0, end: 25.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  // SignUp
  void _signUp(String name, password) {
    // See if the name exists first
    DataSnapshot snapshot;
    cruiser.child('Users/$name').once().then((snapshot) async {
      if (snapshot.value != null) {
        Alert(
                context: context,
                title: "NOTICE!",
                desc: "Your account already exists.")
            .show();
      } else {
        //New one, set name and password
        Map<String, dynamic> data = {
          'Password': password,
          'Notify': 0,
          'Record': 0
        };

        cruiser
            .child('Users/$name')
            .set(data)
            .whenComplete(() => Alert(
                  context: context,
                  title: "Good!",
                  desc: "Your account was created successfully.",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show())
            .catchError((error) {
          print(error);
        });

        // Store the name to SharedPreferences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('Name', nameCtr.text);
        print('Store name ${nameCtr.text} sp successfully!');
      }
    }).catchError((error) {
      print(error);
    });
  }

  //OnTap
  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    // Check the rule of input name and pw
    RegExp reg = new RegExp(r"[0-9A-Za-z]$");
    if (nameCtr.text.isNotEmpty &&
        passwordCtr.text.isNotEmpty &&
        reg.hasMatch(nameCtr.text)) {
      this._signUp(nameCtr.text.trim(), passwordCtr.text.trim());
    } else {
      Alert(
        context: context,
        title: "Failed!",
        desc: "Your account contains illegal characters or empty.",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ).show();
      return;
    }

    // Route and animate
    _animationController.forward().then((f) => Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.white.withOpacity(.1),
            Colors.white.withOpacity(.2),
            Colors.white.withOpacity(.2),
          ])),
          child: Padding(
            padding: EdgeInsets.only(
                left: 30.0,
                top: MediaQuery.of(context).size.height / 2 - 20.0,
                right: 30.0),
            child: Column(
              children: <Widget>[
                FadeAnimation(
                    1.0,
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              controller: nameCtr,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              controller: passwordCtr,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 45,
                ),
                FadeAnimation(
                  1.5,
                  ScaleTransition(
                      scale: _animation,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [Colors.grey, Colors.blueGrey])),
                          child: AnimatedOpacity(
                            opacity: _textVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 50),
                            child: MaterialButton(
                              onPressed: () => _onTap(),
                              minWidth: 100,
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
