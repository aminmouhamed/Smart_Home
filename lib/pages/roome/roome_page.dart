import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/pages/roome/Widgets/RoundedBTN.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Room extends StatefulWidget {
  Room({Key? key}) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  dynamic TSindex(int i) {
    if (i == 1) {
      return temp;
    } else if (i == 3) {
      return smoke.toString();
    } else {
      return null;
    }
  }

  final Pcontroller = PageController();
  final _auth = FirebaseAuth.instance;
  late FlutterLocalNotificationsPlugin Lnotification;
  bool _saving = false;
  String titel = Roomname;
  double btnwidth = 60;
  String temp = '10';
  int smoke = 0;
  int currentPage = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref(Roomname);
  List items = [
    {
      "EnabelNote": true,
      "Note": "Note : Click to turn the lamp on or off ",
      "icon": Icons.lightbulb,
    },
    {
      "EnabelNote": false,
      "text": "30",
      "icon": null,
    },
    {
      "EnabelNote": true,
      "Note": "Note : Click to open or close the window ",
      "icon": Icons.window
    },
    {
      "EnabelNote": false,
      "text": "30",
      "icon": null,
    }
  ];
  List colors = [therdColor, null, null, null];
  List btncolors = [null, null];
  senddata() {}
  getdata() async {
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      // print(data["temp"]);
      setState(() {
        temp = data["temp"].toString();
        smoke = data["smoke"];
      });

      data["light_baulb"] ? btncolors[0] = therdColor : btncolors[0] = null;
      data["window"] ? btncolors[1] = therdColor : btncolors[1] = null;
    });
  }

  @override
  void initState() {
    Lnotification = new FlutterLocalNotificationsPlugin();
    var Android = new AndroidInitializationSettings("mipmap/ic_launcher");
    var ios = new IOSInitializationSettings();
    var initsetting = new InitializationSettings(android: Android, iOS: ios);
    Lnotification.initialize(initsetting,
        onSelectNotification: (payload) => selectNotifications);
    super.initState();
    getdata();
  }

  void showNotifications() {
    var android = AndroidNotificationDetails("6", "smarthome");
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    Lnotification.show(0, "Gaze", "Gas reached high levels .", platform,
        payload: "send message ");
  }

  selectNotifications(String payload) {}
  Color? gazcolorindecator() {
    if (smoke <= 800) {
      return const Color.fromARGB(255, 128, 230, 133);
    } else if (smoke >= 1000) {
      showNotifications();
      return const Color.fromARGB(255, 238, 80, 80);
    } else {
      return const Color.fromARGB(255, 242, 175, 74);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Text(
            titel,
            style: TextStyle(color: primerycolor),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.of(context).pushReplacementNamed("login");
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 40,
                      color: primerycolor,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("home");
                    },
                    icon: Icon(
                      Icons.home,
                      size: 40,
                      color: primerycolor,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("setting");
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 40,
                      color: primerycolor,
                    ))
              ],
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _saving,
          child: Container(
            height: 0.9 * Height!,
            width: Width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      3.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                color: SecendaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                )),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Height! / 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedBTN(
                      color: colors[0],
                      onTab: () {
                        setState(() {
                          // Pcontroller.animateToPage(0,duration: Duration(seconds: 1), curve: Curves.ease);
                          Pcontroller.jumpToPage(0);
                        });
                      },
                      width: btnwidth,
                      icon: Icons.lightbulb,
                    ),
                    RoundedBTN(
                      color: colors[1],
                      onTab: () {
                        setState(() {
                          // Pcontroller.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.ease);
                          Pcontroller.jumpToPage(1);
                        });
                      },
                      width: btnwidth,
                      icon: Icons.thermostat,
                    ),
                    RoundedBTN(
                        color: colors[2],
                        onTab: () {
                          setState(() {
                            // Pcontroller.animateToPage(2, duration: Duration(seconds: 1),curve: Curves.ease);
                            Pcontroller.jumpToPage(2);
                          });
                        },
                        width: btnwidth,
                        icon: Icons.window_outlined),
                    RoundedBTN(
                      color: colors[3],
                      onTab: () {
                        setState(() {
                          // Pcontroller.animateToPage(2, duration: Duration(seconds: 1),curve: Curves.ease);
                          Pcontroller.jumpToPage(3);
                        });
                      },
                      width: btnwidth,
                      icon: Icons.smoke_free,
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (i) {
                        setState(() {
                          currentPage = i;
                          colors = [null, null, null, null];
                          colors[i] = therdColor;
                        });
                      },
                      controller: Pcontroller,
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        return Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Height! * 0.05),
                                child: RoundedBTN(
                                  onTab: () async {
                                    setState(() {
                                      _saving = true;
                                    });
                                    // write here whate the functions dase
                                    if (currentPage == 0) {
                                      if (btncolors[0] == null) {
                                        setState(() {
                                          ref.update({"light_baulb": true});
                                          btncolors[0] == therdColor;
                                        });
                                      } else {
                                        setState(() {
                                          ref.update({"light_baulb": false});
                                          btncolors[0] == null;
                                        });
                                      }
                                    } else if (currentPage == 2) {
                                      if (btncolors[1] == null) {
                                        setState(() {
                                          ref.update({"window": true});
                                          btncolors[1] == therdColor;
                                        });
                                      } else {
                                        setState(() {
                                          ref.update({"window": false});
                                          btncolors[1] == null;
                                        });
                                      }
                                    }

                                    ///////////////////////////////////////////////////////
                                    setState(() {
                                      _saving = false;
                                    });

                                    setState(() {
                                      _saving = false;
                                    });
                                    // write here whate the functions dase
                                  },
                                  width: 0.8 * Width!,
                                  icon: items[i]['icon'],
                                  Note: TSindex(i),
                                  color: i == 0
                                      ? btncolors[0]
                                      : i == 2
                                          ? btncolors[1]
                                          : i == 3
                                              ? gazcolorindecator()
                                              : null,
                                ),
                              ),
                              if (items[i]['EnabelNote'])
                                Padding(
                                  padding: EdgeInsets.only(top: Height! * 0.05),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),
                                    width: Width! * 0.75,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: primerycolor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Center(
                                      child: Text(
                                        items[i]['Note'],
                                        style: TextStyle(
                                            fontSize: 30, color: primerycolor),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
