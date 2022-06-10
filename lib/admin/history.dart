// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smarthome/pages/config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class user_h extends StatelessWidget {
  const user_h({Key? key, required this.user, required this.time})
      : super(key: key);
  final String user;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: Color.fromARGB(255, 80, 83, 86)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              user,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(time, style: TextStyle(color: Colors.white, fontSize: 20))
          ]),
        ),
      ),
    );
  }
}

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<FlSpot> Gaz = [];
  List<FlSpot> Temp = [];
  List<List<String>> Users = [];
  bool show = true;
  bool _saving = true;
  GetUsersHestory() async {
    await Future.delayed(Duration(seconds: 5));
    await FirebaseFirestore.instance
        .collection("h_users")
        .orderBy("time")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          Users.add(
              [doc["user_name"].toString(), doc["time"].toDate().toString()]);
        });
      });
    });
  }

  GetHestory() async {
    await Future.delayed(Duration(seconds: 5));
    await FirebaseFirestore.instance
        .collection("hestory")
        .orderBy("time")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          Gaz.add(FlSpot(doc["time"].toDouble(), doc["gaz"].toDouble()));
          Temp.add(FlSpot(doc["time"].toDouble(), doc["temp"].toDouble()));
        });
      });
      setState(() {
        _saving = false;
      });
    });

    //await Future.delayed(Duration(seconds: 5));
    setState(() {
      show = true;
    });
  }

  @override
  void initState() {
    GetHestory();
    GetUsersHestory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Data Graph"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: ListView(children: [
          ModalProgressHUD(
            inAsyncCall: false,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 83, 86),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(8.0),
                          child: Text("Gaz Graph ",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                      SizedBox(height: 8),
                      LineChartSample2(
                        data: Gaz,
                        Gaz: true,
                        show: show,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 83, 86),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(8.0),
                          child: Text("temperature Graph ",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white))),
                      SizedBox(height: 8),
                      LineChartSample2(
                        Gaz: false,
                        data: Temp,
                        show: show,
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 80, 83, 86),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(8.0),
                    child: Text("Users History",
                        style: TextStyle(fontSize: 20, color: Colors.white))),
                SizedBox(height: 8),
                user_h(user: "user", time: "time"),
                for (int i = Users.length - 1; i >= 0; i--)
                  user_h(user: Users[i][0], time: Users[i][1])
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2(
      {Key? key, required this.data, required this.Gaz, required this.show})
      : super(key: key);
  final List<FlSpot> data;
  final bool Gaz;
  final bool show;

  @override
  _LineChartSample2State createState() =>
      _LineChartSample2State(data, Gaz, show);
}

class _LineChartSample2State extends State<LineChartSample2> {
  _LineChartSample2State(this.data, this.Gaz, this.show);

  final List<FlSpot> data;
  final bool Gaz;
  final bool show;
  List<Color> gradientColors = [
    Color.fromARGB(255, 21, 201, 78),
    Color.fromARGB(255, 48, 127, 148),
  ];
  //List<FlSpot> Gaz = [FlSpot(0, 500)];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color.fromARGB(255, 80, 83, 86)),
            child: !show
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 18.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      mainData(),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('SUN', style: style);
        break;
      case 2:
        text = const Text('MON', style: style);
        break;
      case 3:
        text = const Text('TUE', style: style);
        break;
      case 4:
        text = const Text('WED', style: style);
        break;
      case 5:
        text = const Text('THU', style: style);
        break;
      case 6:
        text = const Text('FRI', style: style);
        break;
      case 7:
        text = const Text('SAT', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      //fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if (Gaz) {
      switch (value.toInt()) {
        case 1000:
          text = '1K';
          break;
        case 2000:
          text = '2k';
          break;
        default:
          return Container();
      }
    } else {
      switch (value.toInt()) {
        case 10:
          text = '10';
          break;
        case 20:
          text = '20';
          break;
        case 30:
          text = '30';
          break;
        case 40:
          text = '40';
          break;
        case 50:
          text = '50';
          break;
        default:
          return Container();
      }
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        //horizontalInterval: 1,
        //verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: Gaz ? 2500 : 50,
      lineBarsData: [
        LineChartBarData(
          spots: data != []
              ? data
              : [
                  FlSpot(0, 1),
                  FlSpot(1, 1),
                  FlSpot(2, 1),
                  FlSpot(3, 1),
                  FlSpot(4, 1),
                  FlSpot(5, 1),
                  FlSpot(6, 1),
                  FlSpot(7, 1),
                ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
