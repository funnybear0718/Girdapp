import 'package:flutter/material.dart';
import 'package:flutter_grid/models/user_model.dart';
import 'file:///E:/romy/Grid/flutter_grid/lib/screens/match/Home.dart';
import 'package:flutter_grid/themes/gridapp_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TAB extends StatefulWidget {
  final BuildContext menuScreenContext;

  TAB({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _TABState createState() => _TABState();
}

class _TABState extends State<TAB> {

  CollectionReference docRef = Firestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List<User> matches = [];
  List<User> newmatches = [];
  User currentUser;
  List<User> users = [];

  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {

    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
    _hideNavBar = false;
    _getCurrentUser();
  }
  _getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return docRef.document("${user.uid}").snapshots().listen((data) async {
      currentUser = User.fromDocument(data);
      _getMatches();
      return currentUser;
    });
  }
  _getMatches() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return Firestore.instance
        .collection('/Users/${user.uid}/Matches')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((ondata) {
      matches.clear();
      newmatches.clear();
      if (ondata.documents.length > 0) {
        ondata.documents.forEach((f) async {
          DocumentSnapshot doc = await docRef.document(f.data['Matches']).get();
          if (doc.exists) {
            User tempuser = User.fromDocument(doc);

            matches.add(tempuser);
            newmatches.add(tempuser);
            if (mounted) setState(() {});
          }
        });
      }
    });
  }
  List<Widget> _buildScreens() {
    return [
      Container(),
      Container(),
      Container(
        child: Center(
            child: CardPictures(
                currentUser, users)),
      ),
      Container(),
      Container(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    ThemeData _theme = Theme.of(context);
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Gridapp.dice_d6),
        title: "Home",
        activeColor: _theme.backgroundColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Gridapp.chat),
        title: ("Chat"),
        activeColor: _theme.backgroundColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Gridapp.heart_empty),
        title: ("Match"),
        activeColor: _theme.backgroundColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Gridapp.videocam),
        title: ("Video"),
        activeColor: _theme.backgroundColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColor: _theme.backgroundColor,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),]
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }
}
