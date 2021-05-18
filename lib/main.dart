import 'dart:async';
import 'package:flutter/material.dart';
import 'Screens/LogIn.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "BMI",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
        ),
        home: MyHomePage(),
      )
  );
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LogIn()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.white,
        //child:FlutterLogo(size:MediaQuery.of(context).size.height)
      child: Image(image: AssetImage("images/splashScreen.jpg"),fit: BoxFit.cover,),
    );
  }
}


