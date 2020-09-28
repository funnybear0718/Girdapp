import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid/models/user_model.dart';
import 'file:///E:/romy/Grid/flutter_grid/lib/screens/match/Information.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swipe_stack/swipe_stack.dart';

List userRemoved = [];

class CardPictures extends StatefulWidget {
  final List<User> users;
  final User currentUser;
  CardPictures(this.currentUser, this.users);

  @override
  _CardPicturesState createState() => _CardPicturesState();
}

class _CardPicturesState extends State<CardPictures>
    with AutomaticKeepAliveClientMixin<CardPictures> {
  // TabbarState state = TabbarState();
  bool onEnd = false;
  GlobalKey<SwipeStackState> swipeKey = GlobalKey<SwipeStackState>();
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    int freeSwipe = 10;
    bool exceedSwipes = false;
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: exceedSwipes,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      height: MediaQuery.of(context).size.height * .78,
                      width: MediaQuery.of(context).size.width,
                      child:
                      //onEnd ||
                      SwipeStack(
                        key: swipeKey,
                        children: widget.users.map((index) {
                          // User user;
                          return SwiperItem(builder:
                              (SwiperPosition position,
                              double progress) {
                            return Material(
                                elevation: 5,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30)),
                                child: Container(
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Swiper(
                                          customLayoutOption:
                                          CustomLayoutOption(
                                            startIndex: 0,
                                          ),
                                          key: UniqueKey(),
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context,
                                              int index2) {
                                            return Container(
                                              height: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height *
                                                  .78,
                                              width: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .width,
                                              child:
                                              CachedNetworkImage(
                                                imageUrl:
                                                index.imageUrl[
                                                index2] ??
                                                    "",
                                                fit: BoxFit.cover,
                                                useOldImageOnUrlChange:
                                                true,
                                                placeholder: (context,
                                                    url) =>
                                                    CupertinoActivityIndicator(
                                                      radius: 20,
                                                    ),
                                                errorWidget: (context,
                                                    url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                              // child: Image.network(
                                              //   index.imageUrl[index2],
                                              //   fit: BoxFit.cover,
                                              // ),
                                            );
                                          },
                                          itemCount:
                                          index.imageUrl.length,
                                          pagination: new SwiperPagination(
                                              alignment: Alignment
                                                  .bottomCenter,
                                              builder: DotSwiperPaginationBuilder(
                                                  activeSize: 13,
                                                  color:
                                                  _theme.backgroundColor,
                                                  activeColor:
                                                  _theme.primaryColor)),
                                          control: new SwiperControl(
                                            color: _theme.primaryColor,
                                            disableColor:
                                            _theme.backgroundColor,
                                          ),
                                          loop: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            48.0),
                                        child: position.toString() ==
                                            "SwiperPosition.Left"
                                            ? Align(
                                          alignment: Alignment
                                              .topRight,
                                          child:
                                          Transform.rotate(
                                            angle: pi / 8,
                                            child: Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape
                                                      .rectangle,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors
                                                          .red)),
                                              child: Center(
                                                child: Text(
                                                    "NOPE",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .red,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        fontSize:
                                                        32)),
                                              ),
                                            ),
                                          ),
                                        )
                                            : position.toString() ==
                                            "SwiperPosition.Right"
                                            ? Align(
                                          alignment:
                                          Alignment
                                              .topLeft,
                                          child: Transform
                                              .rotate(
                                            angle: -pi / 8,
                                            child:
                                            Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape
                                                      .rectangle,
                                                  border: Border.all(
                                                      width:
                                                      2,
                                                      color:
                                                      Colors.lightBlueAccent)),
                                              child: Center(
                                                child: Text(
                                                    "LIKE",
                                                    style: TextStyle(
                                                        color:
                                                        Colors.lightBlueAccent,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 32)),
                                              ),
                                            ),
                                          ),
                                        )
                                            : Container(),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 10),
                                        child: Align(
                                            alignment:
                                            Alignment.bottomLeft,
                                            child: ListTile(
                                                onTap: () =>
                                                    showDialog(
                                                        barrierDismissible:
                                                        false,
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          return Info(
                                                              index,
                                                              widget
                                                                  .currentUser,
                                                              swipeKey);
                                                        }),
                                                title: Text(
                                                  "${index.name}, ${ index.age}",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                                subtitle: Text(
                                                  "${index.address}",
                                                  style: TextStyle(
                                                    color:
                                                    Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                ));
                          });
                        }).toList(growable: true),
                        threshold: 30,
                        maxAngle: 100,
                        //animationDuration: Duration(milliseconds: 400),
                        visibleCount: 5,
                        historyCount: 1,
                        stackFrom: StackFrom.Right,
                        translationInterval: 5,
                        scaleInterval: 0.08,
                        onSwipe: (int index,
                            SwiperPosition position) async {
                          print(position);
                          print(widget.users[index].name);
                          CollectionReference docRef =
                          Firestore.instance.collection("Users");
                          if (position == SwiperPosition.Left) {

                            if (index < widget.users.length) {
                              userRemoved.clear();
                              setState(() {
                                userRemoved.add(widget.users[index]);
                                widget.users.removeAt(index);
                              });
                            }
                          } else if (position ==
                              SwiperPosition.Right) {
                            if (index < widget.users.length) {
                              userRemoved.clear();
                              setState(() {
                                userRemoved.add(widget.users[index]);
                                widget.users.removeAt(index);
                              });
                            }
                          } else
                            debugPrint("onSwipe $index $position");
                        },
                        onRewind:
                            (int index, SwiperPosition position) {
                          swipeKey.currentContext
                              .dependOnInheritedWidgetOfExactType();
                          widget.users.insert(index, userRemoved[0]);
                          setState(() {
                            userRemoved.clear();
                          });
                          debugPrint("onRewind $index $position");
                          print(widget.users[index].id);
                        },
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            widget.users.length != 0
                                ? FloatingActionButton(
                                heroTag: UniqueKey(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  userRemoved.length > 0
                                      ? Icons.replay
                                      : Icons.not_interested,
                                  color: userRemoved.length > 0
                                      ? Colors.amber
                                      : _theme.backgroundColor,
                                  size: 20,
                                ),
                                onPressed: () {
                                  if (userRemoved.length > 0) {
                                    swipeKey.currentState.rewind();
                                  }
                                })
                                : FloatingActionButton(
                              heroTag: UniqueKey(),
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.refresh,
                                color: Colors.green,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                            FloatingActionButton(
                                heroTag: UniqueKey(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  if (widget.users.length > 0) {
                                    print("object");
                                    swipeKey.currentState.swipeLeft();
                                  }
                                }),
                            FloatingActionButton(
                                heroTag: UniqueKey(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.lightBlueAccent,
                                  size: 30,
                                ),
                                onPressed: () {
                                  if (widget.users.length > 0) {
                                    swipeKey.currentState.swipeRight();
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              exceedSwipes
                  ? Align(
                alignment: Alignment.center,
                child: InkWell(
                    child: Container(
                      color: Colors.white.withOpacity(.3),
                      child: Dialog(
                        insetAnimationCurve: Curves.bounceInOut,
                        insetAnimationDuration: Duration(seconds: 2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        child: Container(
                          height:
                          MediaQuery.of(context).size.height * .55,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 50,
                                color: _theme.primaryColor,
                              ),
                              Text(
                                "you have already used the maximum number of free available swipes for 24 hrs.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 120,
                                  color: _theme.primaryColor,
                                ),
                              ),
                              Text(
                                "For swipe more users just subscribe our premium plans.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),),
              )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
