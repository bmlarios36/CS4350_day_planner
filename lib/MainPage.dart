import 'package:flutter/material.dart';
import 'new_task.dart'; // page for making new tasks
import 'day_task_display.dart'; // page for displaying tasks on a given day
import 'important_task_display.dart'; // page for displaying important tasks
import 'calendar_display.dart'; // page for displaying tasks in a calendar view
import 'week_task_display.dart'; // page for displaying tasks for the week
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({required this.User, Key? key}) : super(key: key);
  final String User;
  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          title:Row(
              children: <Widget>[
                SizedBox(
                  width:50,
                  child:Image.network('https://cdn.dribbble.com/users/295073/screenshots/3452437/media/7f4e7e1eccb0e217a8a9f41d190d88a3.jpg?compress=1&resize=800x600&vertical=top'),
                ),
                Text(
                  "Today is ${DateFormat.MMMMd().format(DateTime.now())}",
                  style: const TextStyle(
                      color:Colors.black
                  ),
                )
              ]
          )
      ),
      resizeToAvoidBottomInset: false,
      body:
      Container(
        color: const Color.fromRGBO(232,228,214,100),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(232,228,214,100),
                  border: Border(
                    bottom:BorderSide(width:5, color: Colors.black),
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
                          MaterialPageRoute(builder:(context) => TodayTask(passDay: DateTime.now())),
                        )},
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Today's Tasks",
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(232,228,214,100),
                  border: Border(
                    bottom:BorderSide(width:5, color: Colors.black),
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
                          MaterialPageRoute(builder:(context) =>  const WeekTask()),
                        )},
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "This Week's Tasks",
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(232,228,214,100),
                  border: Border(
                    bottom:BorderSide(width:5, color: Colors.black),
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
                          MaterialPageRoute(builder:(context) =>  const ImportantTask()),
                        )},
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Important Tasks",
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(232,228,214,100),
                  border: Border(
                    bottom:BorderSide(width:5, color: Colors.black),
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
                          MaterialPageRoute(builder:(context) =>  const CalendarDisplay()),
                        )},
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Calendar View",
                            textAlign: TextAlign.center,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) =>  const NewTask()),
          )},
        backgroundColor: const Color.fromRGBO(101, 28, 50, 100),
        label: const Text(
          "New Task",
          style: TextStyle(
              color: Colors.black
          ),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}