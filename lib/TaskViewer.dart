import  'ModifyTask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskViewer extends StatefulWidget {
  const TaskViewer({required this.desc, required this.passDay, required this.taskContent, Key? key}) : super(key: key);
  final DateTime passDay;
  final String desc;
  final String taskContent;
  @override
  State<TaskViewer> createState() => _TaskViewerState();
}

class _TaskViewerState extends State<TaskViewer> {

  void deleteTask()
  {
    String dbDate = "${widget.passDay.day},${widget.passDay.month},${widget.passDay.year}";
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$dbDate/${widget.taskContent}").remove()
        .then((value)
    {
      Navigator.pop(context);
    })
        .catchError((onError)
    {
    });
  }

  static String getDateAndTime(DateTime dateTime)
  {
      final date = DateFormat.MMMMd().format(dateTime);
      final time = DateFormat.jm().format(dateTime);
      return '$date    $time';
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
            ),
        resizeToAvoidBottomInset: false,
        body:Column(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                const Text("Date:                  ",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                  Text(getDateAndTime(widget.passDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(widget.taskContent,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          overflow: TextOverflow.clip
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration:  BoxDecoration(
                      color:  const Color.fromRGBO(200, 200, 200, 100),
                      border:  Border.all(width: 3, color: Colors.black)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(widget.desc,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ]
                  ),
                )
            ),
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                width: 300,
                                child: ElevatedButton(onPressed:deleteTask,
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(103, 127, 163, 100))
                                  ),
                                  child: const Text("Delete"),
                                )
                            )
                          ],
                        )
                    ),
                    Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(onPressed: () => {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder:(context) => ModifyTask(
                                      taskContent: widget.taskContent,
                                      passDay: widget.passDay)
                                  ),
                                )
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(101, 28, 50, 100))
                              ),
                                child: const Text("Modify"),
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                )
            ),
          ],
        )
      );
  }
}
