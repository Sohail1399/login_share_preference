import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_share_preference/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {

  static const String keyLogin = "login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Text("SplashScreen", style: TextStyle(fontSize: 35,fontWeight: FontWeight.w700,color: Colors.white)),
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLogged = sharedPref.getBool(keyLogin);
    Timer(Duration(seconds: 2), (){
      if(isLogged!=null){
        if(isLogged){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage(),));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage(),));
        }
      } else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage(),));
      }

    });
  }
}
