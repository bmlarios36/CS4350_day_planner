import 'package:flutter/material.dart';
import 'day_task_display.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarDisplay extends StatefulWidget {
  const CalendarDisplay({Key? key}) : super(key: key);
  @override
  State<CalendarDisplay> createState() => _CalendarDisplay();
}

class _CalendarDisplay extends State<CalendarDisplay> {
  Map<DateTime, List<int>> _tasks = {};
  var _controller;
  _CalendarDisplay()
  {
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}").onChildChanged.listen((DatabaseEvent event)
    {
      refreshTaskList();
    });
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}").onChildRemoved.listen((DatabaseEvent event)
    {
      refreshTaskList();
    });
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}").onChildAdded.listen((DatabaseEvent event)
    {
      refreshTaskList();
    });
  }
  void refreshTaskList()
  {
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}").onValue.listen((DatabaseEvent event)
    {
      event.snapshot.children.forEach((element)
      {
        List<int> templst = [];
        DateTime day = DateTime.utc(1,1,1);
        element.children.forEach((element)
        {
          day = DateTime.fromMillisecondsSinceEpoch(int.parse(element.child("Date").value.toString()));
          templst.add(0);
        });
        _tasks[day] = templst;
        setState((){});
      });
    });
    setState((){});
  }

  @override
  void initState()
  {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          title:Row(
              children: const <Widget>[
                Text(
                  "Calendar Display",
                  style: TextStyle(
                      color:Colors.black
                  ),
                )
              ]
          )
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _tasks,
              onDaySelected: (selectedDay,events, e) =>
                {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder:(context) => TodayTask(passDay: selectedDay)),
                  )
                },
              initialCalendarFormat: CalendarFormat.month,
                calendarStyle: const CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.pink
                ),
                calendarController: _controller)
          ],
        ),
      ),
    );
  }
}
