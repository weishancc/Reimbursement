import 'package:bookkeeping_app/pages/HomePage.dart';
import 'package:bookkeeping_app/pages/StarterPage.dart';
import 'package:bookkeeping_app/pages/SignUpPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_app/Animation/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _textVisible = true;
  final TextEditingController nameCtr = new TextEditingController();
  final TextEditingController passwordCtr = new TextEditingController();
  DatabaseReference cruiser;

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

  // OnTap
  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    //Check the login information
    DataSnapshot snapshot;
    cruiser = FirebaseDatabase.instance.reference();
    cruiser.child('Users/${nameCtr.text.trim()}').once().then((snapshot) {
      if (snapshot.value != null &&
          snapshot.value['Password'] == passwordCtr.text) {
        print('Welcome! ${nameCtr.text.trim()} !');

        // Route and animate
        _animationController.forward().then((f) => Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: HomePage(nameCtr.text))));
      } else {
        Alert(
          context: context,
          title: "Failed!",
          desc: "Name / password error or doesn't exist",
        ).show();
      }
    });
  }

  // Jump to SignUpPage
  void _signUp() {
    setState(() {
      _textVisible = false;
    });

    _animationController.forward().then((f) => Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: SignUpPage())));
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
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                              controller: nameCtr,
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
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                              controller: passwordCtr,
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
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))),
                ),
                FadeAnimation(
                  1.5,
                  ScaleTransition(
                      scale: _animation,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: AnimatedOpacity(
                            opacity: _textVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 50),
                            child: MaterialButton(
                              onPressed: () => _signUp(),
                              minWidth: 20,
                              child: Text(
                                "✓ Sign Up",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
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
