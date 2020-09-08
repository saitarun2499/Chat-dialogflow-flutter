import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MainPage extends StatefulWidget{
  HomePage createState()=> HomePage();
}


class HomePage extends State<MainPage> {
  FToast fToast;
  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();

  void response(querry) async{
AuthGoogle authGoogle=await AuthGoogle(fileJson: "assets/turing-handler-288402-6a8ec671f18c.json").build();
Dialogflow dialogflow=await Dialogflow(authGoogle:authGoogle,language: Language.english);
AIResponse aiResponse=await dialogflow.detectIntent(querry);
setState(() {
  messages.insert(0, {
    "data": 0,
    "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
  });
});
  }
final messageInsert=TextEditingController();
  List<Map> messages=List();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
appBar: AppBar(
  title: Text("Developer Student Clubs"),
  backgroundColor: Colors.blueAccent,
),
     body: Container(
       child: Center(
         child:Column(
           children: <Widget>[

             Flexible(child: ListView.builder(
               reverse: true,
               padding: EdgeInsets.all(10.0),

                 itemCount: messages.length,
                 itemBuilder: (context,index)=>messages[index]["data"]==0?Text(messages[index]["message"].toString()):Text(messages[index]["message"].toString(),textAlign: TextAlign.right,)),),
             Divider(height: 3.0,),
             Container(

               padding: EdgeInsets.only(bottom: 50.0,left: 20.0),
               margin: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Row(

                 children: <Widget>[
                   Flexible(child: TextField(

                     controller: messageInsert,
                     decoration: InputDecoration.collapsed(hintText: "Send your message"),
                   ),),
                   Container(

margin: EdgeInsets.symmetric(horizontal: 4.0),
                     child:

                     IconButton(

                       icon: Icon(

                         Icons.send,

                         size: 30.0,
                         color: Colors.grey,
                       ),onPressed: (){
                         if(messageInsert.text.isEmpty){
                           print("Empty Message");

                         }else{

                           setState(() {
                             messages.insert(0,
                                 {"data": 1, "message": messageInsert.text});
                            // Image(image: AssetImage('assets/home1.png'),);
                           });
                           response(messageInsert.text);
                           messageInsert.clear();
                         }
                     },)
                   )
                 ],
               ),
             )

           ],
         )
       ),
     ),
      drawer:
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),

              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),




      bottomNavigationBar: BottomAppBar(


        child:

        Row(
          children: [

          IconButton(icon: Icon(Icons.menu), onPressed: () {
            _scaffoldKey.currentState.openDrawer();

            }),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {



            }),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.add), onPressed: () {
     Fluttertoast.showToast( msg: "This is Center Short Toast",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.blue,
         textColor: Colors.white,
         fontSize: 16.0
     );

      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  


}




ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    textTheme: _buildShrineTextTheme(base.textTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    button: base.button.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
  )
      .apply(
    fontFamily: 'Rubik',
    displayColor: shrineBrown900,
    bodyColor: shrineBrown900,
  );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;