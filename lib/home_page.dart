import 'package:flutter/material.dart';
import 'package:login_share_preference/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String saveEmail = "";
  String savePass = "";
  @override
  void initState() {
    super.initState();
    getValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25,right: 25),
                  width: double.infinity,
                  height: 45,
                  child: Card(
                    color: Colors.greenAccent,
                    elevation: 5,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      child: Center(child: Text("Email: $saveEmail")),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25,right: 25),
                  width: double.infinity,
                  height: 45,
                  child: Card(
                   color: Colors.greenAccent,
                    elevation: 5,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),),
                      child: Center(child: Text("Password: $savePass")),
                  ),
                ),

                Flex(
                  direction: axisDirectionToAxis(AxisDirection.down),
                  children:[
                  ElevatedButton(onPressed:() {
                    logOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                      child: Text("Logout")
                  ),
                 ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 void logOut() async{
   var prefs = await SharedPreferences.getInstance();
   prefs.clear();
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      saveEmail = prefs.getString("email") ?? "No value";
      savePass = prefs.getString("pass") ?? "No value";
    });
  }
}
