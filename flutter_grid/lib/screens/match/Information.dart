import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid/models/user_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swipe_stack/swipe_stack.dart';


class Info extends StatelessWidget {
  final User currentUser;
  final User user;

  final GlobalKey<SwipeStackState> swipeKey;
  Info(
      this.user,
      this.currentUser,
      this.swipeKey,
      );

  @override
  Widget build(BuildContext context) {
    //  if()

    //matches.any((value) => value.id == user.id);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: mediaQueryData.size.height / 2 + 40,
              width: MediaQuery.of(context).size.width,
              child: Swiper(
                key: UniqueKey(),
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index2) {
                  return user.imageUrl.length != null
                      ? Hero(
                    tag: "abc",
                    child: CachedNetworkImage(
                      imageUrl: user.imageUrl[index2],
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      placeholder: (context, url) =>
                          CupertinoActivityIndicator(
                            radius: 20,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                    ),
                  )
                      : Container();
                },
                itemCount: user.imageUrl.length,
                pagination: new SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 120),
                    builder: DotSwiperPaginationBuilder(
                        activeSize: 13,
                        color: _theme.backgroundColor,
                        activeColor: _theme.primaryColor)),
                control: new SwiperControl(
                  color: _theme.primaryColor,
                  disableColor: _theme.backgroundColor,
                ),
                loop: false,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: Colors.white),
                  height: mediaQueryData.size.height / 2,
                  width: mediaQueryData.size.width,
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: Text('On Grid', style: TextStyle(color: _theme.backgroundColor),),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "${user.name}, ${user.age}",
                            style: TextStyle(
                                color: _theme.backgroundColor,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            """Lorem ipsum dolor sit amet, consectetur
adipiscing elit, sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua.""",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Positioned(
              bottom: mediaQueryData.size.height / 2 - 30,
              child: Container(
                width: mediaQueryData.size.width,
                alignment: Alignment.center,
                height: 60,
                child: SizedBox(
                    width: 60,
                    height: 60,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white),
                    child: Image.asset('assets/auth/map_mark.png', fit: BoxFit.fitHeight,),
                  ),
                )
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),]),
                  width: mediaQueryData.size.width,
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                          heroTag: UniqueKey(),
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            swipeKey.currentState.swipeLeft();
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
                            Navigator.pop(context);
                            swipeKey.currentState.swipeRight();
                          }),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
