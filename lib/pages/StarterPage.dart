import 'package:bookkeeping_app/pages/LoginPage.dart';
import 'package:bookkeeping_app/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:bookkeeping_app/Animation/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterPage extends StatefulWidget {
  @override
  _StarterPageState createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _textVisible = true;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation =
        Tween<double>(begin: 1.0, end: 25.0).animate(_animationController);
    super.initState();
    _loadName();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  Future<void> _loadName() async {
    // Get the name from SharedPreferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var loginName = sharedPreferences.get('Name');

    if (loginName != null) {
      _animationController.forward().then((f) => Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: HomePage(loginName))));
    }
  }

  void _onTap() {
    setState(() {
      _textVisible = false;
    });

    _animationController.forward().then((f) => Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          /* Add the gradient */
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(.1),
                Colors.white.withOpacity(.2),
                Colors.white.withOpacity(.2),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FadeAnimation(
                    .5,
                    Text(
                      'Pay Back \nMoney ASAP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                    1,
                    Text(
                      "Easily record debits \nby clicking",
                      style: TextStyle(
                          color: Colors.white70, height: 1.2, fontSize: 18),
                    )),
                SizedBox(
                  height: 120,
                ),
                FadeAnimation(
                  1.2,
                  /* Scale Animation */
                  ScaleTransition(
                      scale: _animation,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [Colors.yellow, Colors.orange])),

                          /* Opacity Animation (透明度的動畫) */
                          child: AnimatedOpacity(
                            opacity: _textVisible ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 50),
                            child: MaterialButton(
                              onPressed: () => _onTap(),
                              minWidth: double.infinity,
                              child: Text(
                                "Start",
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
