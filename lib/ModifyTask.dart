import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ModifyTask extends StatefulWidget {
  const ModifyTask({required this.passDay, required this.taskContent, Key? key}) : super(key: key);
  final DateTime passDay;
  final String taskContent;
  @override
  State<ModifyTask> createState() {
    return _ModifyTaskState();
  }
}
//------------------------------------------------------------------------------
class _ModifyTaskState extends State<ModifyTask> {
  final _formKey = GlobalKey<FormState>();
  late String desc = "";
  late String taskContent = "";
  late DateTime theDate = DateTime.now();
  late bool important = false;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  DateTime getDateTimeFromEpoch(String ms)
  {
    int milliepoch = int.parse(ms);
    return DateTime.fromMillisecondsSinceEpoch(milliepoch);
  }
  
  void retrieveTaskState()
  {
    String dbDate = "${widget.passDay.day},${widget.passDay.month},${widget.passDay.year}";
    FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$dbDate/${widget.taskContent}").onValue.listen((DatabaseEvent event)
    {
      desc = event.snapshot.child("Description").value.toString();
      taskContent = widget.taskContent;
      if(event.snapshot.child("Important").value == true) {
        important = true;
      }
      theDate = getDateTimeFromEpoch(event.snapshot.child("Date").value.toString());
      titleController.text = taskContent;
      descController.text = desc;
      setState((){});
    });
  }
  //initializes the current time using initState
  @override
  void initState()
  {
    super.initState();
    retrieveTaskState();
  }

  //following three functions handle async picker of date and time using SDK functions
  Future picktheDateTime(pickDate) async
  {
    final date = await pickDateTime(theDate, pickDate: pickDate);
    if(date == null) {return null;}
    setState(() => {
      theDate = date
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate, {required bool pickDate, DateTime? firstDate,})
  async{
    if(pickDate)
    {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate:theDate,
          lastDate: DateTime(2101)
      );
      if(date == null)
      {
        return null;
      }
      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    }
    else
    {
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 12, minute:0)
      );
      if(timeOfDay == null)
      {
        return null;
      }
      final date = DateTime(initialDate.year, initialDate.month,initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }

  }

  //handles form submission
  void updateForm(){
    final isValid = _formKey.currentState!.validate();
    if(isValid)
    {
      String newdbDate = "${theDate.day},${theDate.month},${theDate.year}";
      String olddbDate = "${widget.passDay.day},${widget.passDay.month},${widget.passDay.year}";
      FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$newdbDate/${titleController.text}").set({
            "Task" : titleController.text,
            "Date" : theDate.millisecondsSinceEpoch,
            "Description" : descController.text,
            "Important" : important
      }).then((value)
      {
        FirebaseDatabase.instance.ref("Users/${FirebaseAuth.instance.currentUser?.uid}/$olddbDate/${widget.taskContent}").remove()
            .then((value)
        {
          Navigator.pop(context);
        });
        });
    }
  }
  //these two functions return the formatted time and date
  static String getDate(DateTime dateTime)
  {
    final date = DateFormat.yMMMEd().format(dateTime);
    return '$date';
  }
  static String getTime(DateTime dateTime)
  {
    final time = DateFormat.Hm().format(dateTime);
    return '$time';
  }
  //disposes of our controllers for the form
  @override
  void dispose()
  {
    descController.dispose();
    titleController.dispose();
    super.dispose();
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
                  "Create a New Task",
                  style: TextStyle(
                      color:Colors.black
                  ),
                )
              ]
          )
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: const Color.fromRGBO(232,228,214,100),
            child: Column(
              children: <Widget>[
                Container(
                  padding:const EdgeInsets.fromLTRB(5,20,5,20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Name Of Task",
                          ),
                          onFieldSubmitted: (_) {},
                          validator: (task) => task != null && task.isEmpty ? 'This field is required':null,
                          controller: titleController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(5,20,5,20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Description",
                          ),
                          onFieldSubmitted: (_) {},
                          controller: descController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(5,20,5,20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(getDate(theDate)),
                                trailing: const Icon(Icons.arrow_drop_down),
                                onTap: () => picktheDateTime(true),
                              ),
                            ]
                        ),
                      ),
                      Expanded(
                        child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(getTime(theDate)),
                                trailing: const Icon(Icons.arrow_drop_down),
                                onTap: () => picktheDateTime(false),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(5,20,5,20),
                  child: Row(
                    children:<Widget>[
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("Important"),
                          checkColor: Colors.white,
                          value: important,
                          activeColor: Colors.green,
                          onChanged:(bool? val) {
                            setState(()
                            {
                              important = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(5,50,5,20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () => updateForm(),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(101, 28, 50, 100)),
                              ),
                              child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white
                                  )
                              )
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
