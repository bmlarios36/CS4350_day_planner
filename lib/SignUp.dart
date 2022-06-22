import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailcontroller = TextEditingController();
  var pwcontroller = TextEditingController();

  Future signUp() async {
    try
    {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: pwcontroller.text
      ).then((value) => Navigator.pop(context));
    } on FirebaseAuthException catch (e)
    {
      print(e);
    }

}
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
                    "Sign Up",
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
                      onPressed: () {
                        signUp();
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
                        Navigator.pop(context)
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(103, 127, 163, 100))
                      ),
                      child: const Text("Return to Log In"),
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
