import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  List bgImages = [
    "https://dm0qx8t0i9gc9.cloudfront.net/thumbnails/image/rDtN98Qoishumwih/summer-background-abstract-background-wallpaper-use-for-presentation_HDDYoJOhMg_thumb.jpg",
    "https://i.pinimg.com/564x/a9/6b/6c/a96b6cfa26ac9b4d22ed475ff1189511.jpg",
    "https://images.unsplash.com/photo-1558470622-bd37a3c489e7?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWp7i3ufrhRu2AAoZdKBt_9ZyFJdMoXdJVgVy87HLfiw&s",
    "https://cdn.photoroom.com/v1/assets-cached.jpg?path=backgrounds_v3/black/Photoroom_black_background_extremely_fine_texture_only_black_co_c756a0c0-4895-4275-845b-7a20f085e432.jpg",
  ];
  String backgroundImage =
      "https://images.unsplash.com/photo-1569250814530-1e923fd61bc6?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D";
  bool isDigital = false;
  bool isAnalog = false;
  bool isStrap = false;
  bool isTimer = false;
  bool isReverse = false;

  bool isTimerClock = false;

  int hour = 0;
  int minute = 0;
  int second = 0;

  List<Map<String, dynamic>> timerHistory = [];

  int h = 00;
  int m = 00;
  int s = 00;

  void timerClock() {
    isTimerClock = true;
    Future.delayed(
      const Duration(microseconds: 1),
      () {
        setState(() {
          if (isTimerClock) {
            s++;
          }
          if (s > 59) //  60 > 59
          {
            m++;
            s = 0;
          }
          if (m > 59) {
            h++;
            m = 0;
          }

          if (h > 12) {
            h = 0;
          }
        });
        if (isTimerClock) {
          timerClock();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextScaler textScaler = MediaQuery.textScalerOf(context);
    Size size = MediaQuery.of(context).size;

    double height = size.height;
    double width = size.width;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        DateTime dateTime = DateTime.now();
        hour = dateTime.hour;
        minute = dateTime.minute;
        second = dateTime.second;
      });
    });
    return Scaffold(
      drawer: Drawer(
        // backgroundColor: Colors.grey,
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Kartik Dudharejiya"),
              accountEmail: Text("dudharejiyakartik@gmail.com"),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/137186473?v=4"),
              ),
              // currentAccountPictureSize: Size(80, 80),
            ),
            ListTile(
              leading: const Text("01"),
              title: const Text("Digital Clock"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isDigital,
                onChanged: (val) {
                  isDigital = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("02"),
              title: const Text("Analog Clock"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isAnalog,
                onChanged: (val) {
                  isAnalog = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("03"),
              title: const Text("Strap Watch"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isStrap,
                onChanged: (val) {
                  isStrap = val;
                  setState(() {});
                },
              ),
            ),
            ListTile(
              leading: const Text("04"),
              title: const Text("Timer"),
              subtitle: const Text("clock"),
              trailing: Switch(
                value: isTimer,
                onChanged: (val) {
                  isTimer = val;
                  setState(() {});
                },
              ),
            ),
            const ListTile(
              leading: Text("06"),
              title: Text("Background Image"),
              subtitle: Text("clock"),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: bgImages
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          setState(() {
                            backgroundImage = e;
                          });
                        },
                        child: Container(
                          height: height * 0.13,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                          margin: const EdgeInsets.all(5),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text("Timer App"),
          backgroundColor: Colors.grey),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Visibility(
              visible: isAnalog,
              child: Stack(
                children: [
                  ...List.generate(
                    60,
                    (index) => Transform.rotate(
                      angle: index * (pi * 2) / 60,
                      child: Divider(
                        color: (index % 5 == 0) ? Colors.red : Colors.grey,
                        thickness: (index % 5 == 0) ? 4 : 2,
                        indent:
                            (index % 5 == 0) ? height * 0.42 : height * 0.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isAnalog,
              child: CircleAvatar(
                radius: width * 0.015,
                backgroundColor: Colors.black26,
              ),
            ),

            // Second

            Visibility(
              visible: isAnalog,
              child: Transform.rotate(
                angle: second * (pi * 2) / 60 + pi / 2,
                child: Divider(
                  color: Colors.redAccent,
                  thickness: 2,
                  indent: width * 0.09,
                  endIndent: width * 0.4,
                ),
              ),
            ),

            // Minute
            Visibility(
              visible: isAnalog,
              child: Transform.rotate(
                // Rotate for 90°
                angle: pi / 2,
                child: Transform.rotate(
                  angle: minute * (pi * 2) / 60,
                  child: Divider(
                    color: Colors.blue,
                    thickness: 3,
                    indent: width * 0.15,
                    endIndent: width * 0.45,
                  ),
                ),
              ),
            ),

            // hour
            Visibility(
              visible: isAnalog,
              child: Transform.rotate(
                angle: pi / 2,
                child: Transform.rotate(
                  angle: hour * (pi * 2) / 12,
                  child: Divider(
                    color: Colors.black54,
                    thickness: 5,
                    indent: width * 0.25,
                    endIndent: width * 0.45,
                  ),
                ),
              ),
            ),

            Visibility(
              visible: isDigital,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: height * 0.086,
                    width: width * 0.2,
                    margin: EdgeInsets.all(height * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(width * 0.035),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              (hour % 12).toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: textScaler.scale(25),
                                fontWeight: FontWeight.w800,
                                height: 2.5,
                              ),
                            ),
                          ),
                        ),
                        const Text("Hour")
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.086,
                    width: width * 0.2,
                    margin: EdgeInsets.all(height * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(width * 0.035),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              (minute).toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: textScaler.scale(25),
                                fontWeight: FontWeight.w800,
                                height: 2.5,
                              ),
                            ),
                          ),
                        ),
                        const Text("Minute")
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.086,
                    width: width * 0.2,
                    margin: EdgeInsets.all(height * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(width * 0.035),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              (second).toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: textScaler.scale(25),
                                fontWeight: FontWeight.w800,
                                height: 2.5,
                              ),
                            ),
                          ),
                        ),
                        const Text("Second")
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: height * 0.03,
                        width: width * 0.07,
                        margin: EdgeInsets.only(top: height * 0.055),
                        padding: EdgeInsets.all(height * 0.001),
                        color: Colors.orange.withOpacity(0.5),
                        alignment: Alignment.center,
                        child: Text((hour < 12) ? 'AM' : 'PM'),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Strap Watch

            // second
            Visibility(
              visible: isStrap,
              child: Transform.scale(
                scale: 8,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  value: second / 60,
                  color: Colors.redAccent,
                ),
              ),
            ),

            // Minute
            Visibility(
              visible: isStrap,
              child: Transform.scale(
                scale: 7,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  value: minute / 60,
                  color: Colors.blue,
                ),
              ),
            ),

            // Hour
            Visibility(
              visible: isStrap,
              child: Transform.scale(
                scale: 5,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  value: (hour % 12) / 12,
                  color: Colors.black54,
                ),
              ),
            ),
            Visibility(
              visible: isTimer,
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: textScaler.scale(35),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: (timerHistory.isNotEmpty)
                          ? Column(
                              children: [
                                ...timerHistory
                                    .map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          timerHistory.remove(e);
                                          setState(() {});
                                        },
                                        child: Card(
                                          margin: const EdgeInsets.all(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Hour\n  ${e['hour']}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaler.scale(15),
                                                  ),
                                                ),
                                                Text(
                                                  "Minute\n  ${e['minute']}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaler.scale(15),
                                                  ),
                                                ),
                                                Text(
                                                  "Second\n  ${e['second']}",
                                                  style: TextStyle(
                                                    fontSize:
                                                        textScaler.scale(15),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            )
                          : Image.network(
                              "https://t4.ftcdn.net/jpg/05/33/54/55/360_F_533545570_M0xIF8ZO6lN5XKgDLug2MFLhhLOwaAYq.jpg"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (!isTimerClock) {
                                timerClock();
                              }
                              setState(() {});
                            },
                            child: const Text("Start"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              isTimerClock = false;
                              timerHistory.add({
                                'hour': h,
                                'minute': m,
                                'second': s,
                              });
                              setState(() {});
                            },
                            child: const Text("Stop"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              isTimerClock = false;
                              s = m = h = 0;
                              timerHistory = [];
                              setState(() {});
                            },
                            child: const Text("Restart"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
