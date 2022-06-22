import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'TaskViewer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

//get all tasks from DB, list display them and their attributes

class TodayTask extends StatefulWidget {
  const TodayTask({Key? key, required this.passDay}) : super(key: key);
  final DateTime passDay;
  @override
  State<TodayTask> createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {
  var entries = [];
  _TodayTaskState()
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
    var allTasks = [];
    String dbDate = "${widget.passDay.day},${widget.passDay.month},${widget.passDay.year}";
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$dbDate").onValue.listen((DatabaseEvent event)
    {
      event.snapshot.children.forEach((element)
      {
        allTasks.add(element);
        setState((){});
      });
    });
    entries = allTasks;
    setState((){});
  }

  String getDisplayDate(String ms)
  {
    DateTime dateTime = getDateTimeFromEpoch(ms);
    final date = DateFormat.yMMMEd().format(dateTime);
    return '$date';
  }
  DateTime getDateTimeFromEpoch(String ms)
  {
    int milliepoch = int.parse(ms);
    return DateTime.fromMillisecondsSinceEpoch(milliepoch);
  }

  static String getDate(DateTime dateTime)
  {
    if(dateTime.day == DateTime.now().day)
      {
        return 'Today';
      }
    else
    {
      final date = DateFormat.MMMMd().format(dateTime);
      return '$date';
    }
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
              children:<Widget>[
                 Text(
                  "Tasks for ${getDate(widget.passDay)}",
                  style: const TextStyle(
                      color:Colors.black
                  ),
                )
              ]
          )
      ),
      body: entries.isEmpty ?
      const Center(
        child: Text(
            "No Tasks Today!",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(103, 127, 163, 100)
          ),
        ),
      )
      :
      ListView.builder(
        itemCount: entries.length,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(232,228,214,100),
                  border: Border(
                    bottom:BorderSide(width:5, color: Colors.black),
                  )
              ),
              child: TextButton(
                style:TextButton.styleFrom(
                  primary:Colors.black,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => TaskViewer(
                        desc: entries[index].child("Description").value,
                        passDay: getDateTimeFromEpoch(entries[index].child("Date").value.toString()),
                        taskContent: entries[index].child("Task").value)
                    ),
                  )},
                child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                  child:
                                    Text(
                                        entries[index].child("Task").value,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                    )
                              ),
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child:
                                  Text(
                                      entries[index].child("Description").value,
                                    overflow: TextOverflow.ellipsis,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                      getDisplayDate(entries[index].child("Date").value.toString())
                                  )
                                ],
                              ),
                              Row(
                                  children: <Widget>[
                                    if(entries[index].child("Important").value == true)
                                      const Icon(Icons.star, color:Colors.amber )
                                    ]
                              ),
                            ],
                          ),
                        ),
                      ),
                  ]
                ),
              ),
            );
          })
    );
  }
}
