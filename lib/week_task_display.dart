import 'package:flutter/material.dart';
import 'day_task_display.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

//pole tasks each day, determine if there is an important one, get the number of tasks and display it

class WeekTask extends StatefulWidget {
  const WeekTask({ Key? key}) : super(key: key);
  @override
  State<WeekTask> createState() => _WeekTask();
}

class _WeekTask extends State<WeekTask> {
  late DateTime firstDayOfWeek;
  late List<int> noOfTasks = [0,0,0,0,0,0,0];
  void queryTaskForEachDay()
  async
  {
    for(int i = 0; i < 7; i++)
      {
        DateTime day = firstDayOfWeek.add(Duration(days:i));
        String dbDate = "${day.day},${day.month},${day.year}";
        final snapshot = await FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$dbDate").get();
        if(snapshot.exists)
          {
            noOfTasks[i] = (snapshot.children.length);
          }
        else
          {
            noOfTasks.add(0);
          }
        setState((){});
      }
    setState((){});
  }
  @override
  void initState()
  {
    super.initState();
    var d = DateTime.now();
    var weekDay = d.weekday;
    firstDayOfWeek = d.subtract(Duration(days: weekDay));
    queryTaskForEachDay();
  }

  String getWeekLength()
  {
    final firstDay = DateFormat.MMMMd().format(firstDayOfWeek);
    final lastDay = DateFormat.MMMMd().format(firstDayOfWeek.add(const Duration(days:6)));
    return '$firstDay - $lastDay';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),

            backgroundColor: Colors.white,
            shadowColor: Colors.black,
            title:Column(
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Text(
                      "Tasks for the week of ...",
                      style: TextStyle(
                          fontSize: 20,
                          color:Colors.black
                      ),
                    )
                  ]
                  ),
                Row(
                  children:<Widget>[
                    Text(
                      getWeekLength(),
                      style: const TextStyle(
                          fontSize: 20,
                          color:Colors.black
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
      body:
      Container(
        color: const Color.fromRGBO(232,228,214,100),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:0))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: const <Widget>[
                                  Text("Sunday"),
                                ],
                              )
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Text("${noOfTasks[0]} Tasks Today",
                                    style: const TextStyle(
                                      color:Colors.teal,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:1))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Monday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[1]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:2))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Tuesday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[2]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:3))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Wednesday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[3]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:4))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Thursday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[4]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:5))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Friday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[5]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(232,228,214,100),
                    border: Border(
                      bottom:BorderSide(width:2, color: Colors.black),
                    )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style:TextButton.styleFrom(
                          primary:Colors.black,
                          padding: const EdgeInsets.all(15),
                          textStyle: const TextStyle(fontSize: 30),
                        ),
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) =>  TodayTask(passDay: firstDayOfWeek.add(const Duration(days:6))),
                          ))},
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: Row(
                                  children: const <Widget>[
                                    Text("Saturday"),
                                  ],
                                )
                            ),
                            Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Text("${noOfTasks[6]} Tasks Today",
                                      style: const TextStyle(
                                        color:Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
