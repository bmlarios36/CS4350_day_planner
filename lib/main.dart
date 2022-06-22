import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'MainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
//------------------------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//------------------------------------------------------------------------------
class _MyHomePageState extends State<MyHomePage> {
  var emailcontroller = TextEditingController();
  var pwcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Container(
        color: const Color.fromRGBO(232,228,214,100),
        child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Row(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                        "Log In",
                    style: TextStyle(
                      color: Color.fromRGBO(101, 28, 50, 100),
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                    ),)
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                     SizedBox(
                       width:300,
                       child: TextField(
                         controller: emailcontroller,
                         decoration: const InputDecoration(
                           border:UnderlineInputBorder(),
                           labelText: 'E-Mail',
                         ),
                       ),
                     )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    SizedBox(
                      width:300,
                      child: TextField(
                        obscureText: true,
                        controller: pwcontroller,
                        decoration: const InputDecoration(
                          border:UnderlineInputBorder(),
                          labelText: 'Password',

                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () => {
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailcontroller.text, 
                                password: pwcontroller.text)
                            .then((value) => {
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                            builder: (BuildContext context) =>  MainPage(User: emailcontroller.text))
                            )
                            }).catchError((error)
                            {
                              print(error.toString());
                            })
                          },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(101, 28, 50, 100))
                        ),
                          child: const Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) =>  const SignUpPage()),
                        )
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(103, 127, 163, 100))
                        ),
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}