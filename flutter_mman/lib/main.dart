import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmodhttp/client.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
  
class Server{
  static String? ip;
  static String? map;
  static String? gamemode;
  static String? hostname;
  static String? uptime;

  static List? players;
  static List commands = [
    {'key' : 'freeze', 'value' : 'Freeze Player'},
    {'key'  :'kill', 'value' : 'Kill Player'},
    {'key' : 'kick' , 'value' : 'Kick Player'},
    {'key' : 'ban', 'value' : 'Ban Player'},
    {'key' : 'strip', 'value' : "Take player's weapons"},
    {'key' : 'burn', 'value' : 'Burn Player'},
  ];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gmodhttp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int pageIndex = 0;
  
  String gamemode = "?";
  String player_count = "?";
  String map = "?";
  String uptime = "?";


  String hostname = "Loading...";

  final TextEditingController _textFieldController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void sendCommand(command){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'command:$command'}
    );    
  }

  void sendChangeMap(map){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'changemap:$map'}
    );
  }

  void askChangeMap(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Type Map Name',
            style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
            ),
          backgroundColor: Color.fromRGBO(48,	54,	73, 100),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "", focusColor: Colors.white, fillColor: Colors.white, focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            cursorColor: Colors.white,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
            ),
          ),
          
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
              'Send',
              style: TextStyle(color: Colors.black)),
              onPressed: () => {
                sendChangeMap(_textFieldController.text),
                setState((){}),
                Navigator.pop(context)
              },
            )
          ]
        );
      }
    );
  }

  void askChangePassword(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Type New Password',
            style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
            ),
          backgroundColor: Color.fromRGBO(48,	54,	73, 100),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "", focusColor: Colors.white, fillColor: Colors.white, focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            cursorColor: Colors.white,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
            ),
            
          ),
          
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
              'Send',
              style: TextStyle(color: Colors.black)),
              onPressed: () => {
                sendPassword(_textFieldController.text),
                setState((){}),
                Navigator.pop(context)
              },
            )
          ]
        );
      }
    );
  }  

  void askChangeHostname(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Type Hostname',
            style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
            ),
          backgroundColor: Color.fromRGBO(48,	54,	73, 100),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "", focusColor: Colors.white, fillColor: Colors.white, focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            cursorColor: Colors.white,
             style: GoogleFonts.openSans(
               textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
             ),
            
          ),
          
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
              'Send',
              style: TextStyle(color: Colors.black)),
              onPressed: () => {
                sendHostname(_textFieldController.text),
                setState((){}),
                Navigator.pop(context)
              },
            )
          ]
        );
      }
    );
  }  

  void askCommand(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Type Command',
            style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
            ),
          backgroundColor: Color.fromRGBO(48,	54,	73, 100),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "", focusColor: Colors.white, fillColor: Colors.white, focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
            cursorColor: Colors.white,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
            ),
            
          ),
          
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
              'Send',
              style: TextStyle(color: Colors.black)),
              onPressed: () => {
                sendCommand(_textFieldController.text),
                setState((){}),
                Navigator.pop(context)
              },
            )
          ]
        );
      }
    );
  }   


  void sendRestart(){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'restart:restart'}
    );
  }  

  void sendStop(){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'stop:stop'}
    );
  } 

  void sendHostname(hostname){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'changehostname:$hostname'}
    );
  }     

  void sendKick(){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'kickall:kickall'}
    );
  }    

  void sendPassword(password){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : 'changepassword:$password'}
    );
  }      

  Future<void> getData() async{
    try{
      final response = await http
      .get(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/status.html'));

      if (response.statusCode != 200){
        getData();
        return;
      }

      var json = jsonDecode(response.body) as Map<String, dynamic>;
      var players = jsonDecode(json['players']) as List<dynamic>;

      setState((){
        Server.hostname = json["hostname"];
        Server.gamemode = json["gamemode"];
        player_count = (players.length).toString();
        Server.players = players;
        Server.map = json["map"];
        Server.uptime = json["uptime"].round().toString();
      });
     
    } catch (exception){
      print(exception);
    }
    finally{
      Future.delayed(const Duration(seconds: 5), ()async{
        getData();
      });     
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
    setState((){});
    Future.delayed(const Duration(seconds: 5), ()async{
      getData();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(
      backgroundColor: const Color.fromRGBO(48,	54,	73, 100),
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.


      children: <Widget>[
        Align(
          alignment: Alignment(Alignment.center.x - 0.7,-0.8),
          child: Text(
              "mman",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)
              )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x,-0.8),
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 1,
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
              ))
            ),
            child: Text(
              "server",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white, fontSize: 30)
               )
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x + 0.7,-0.8),
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 1,
            ),
            child: TextButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => const MyHomePage_Client(title: 'client'),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero
                  )
                );
              },
              child:  Text(
                "client",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white38, fontSize: 30)
                )
              )
            )
          )
        ),        

        Align(
          alignment: Alignment(Alignment.center.x - 0.5, -0.5),
          child: Container(
            width: 50,
            padding: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ))
            ),
            child: const Icon(
              Icons.group,
              color: Colors.white,
              size: 32,
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x - 2.55, -0.4),
          child: Container(
            width: 340,
            child: Text(
              player_count,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
              style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w200)
              )
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x + 0.5,-0.5),
          child: Container(
            width: 50,
            padding: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ))
            ),
            child: const Icon(
              Icons.map,
              color: Colors.white,
              size: 32,
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x + 2.52, -0.4),
          child: Container(
            width: 340,
            child: Text(
              Server.map ?? "?",
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.visible,
              style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w200)
              )
            )
          )
        ), 

        Align(
          alignment: Alignment(Alignment.center.x -0.5,-0.2),
          child: Container(
            width: 50,
            padding: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ))
            ),
            child: const Icon(
              Icons.sports_esports,
              color: Colors.white,
              size: 32,
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x -2.52, -0.1),
          child: Container(
            width: 340,
            child: Text(
              Server.gamemode ?? "?",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w200)
              )
            )  
          )
        ), 

        Align(
          alignment: Alignment(Alignment.center.x + 0.5,-0.2),
          child: Container(
            width: 50,
            padding: const EdgeInsets.only(bottom: 1),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ))
            ),
            child: const Icon(
              Icons.schedule,
              color: Colors.white,
              size: 32,
            )
          )
        ),   

        Align(
          alignment: Alignment(Alignment.center.x + 2.52, -0.1),
          child: Container(
            width: 340,
            child: Text(
              '${Server.uptime}m' ?? "?",
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w200)
              )
            )  
          )
        ),   

        // buttons
    
        Align(
          alignment: Alignment(Alignment.center.x -0.5, 0.5),
          child: Container(
            width: 110,
            height: 40,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: askChangeMap,
                child: Text(
                  "Change map",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)
                 ),
                 textAlign: TextAlign.center
                ),  
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x -0.5, 0.65),
          child: Container(
            width: 110,
            height: 40,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: askChangePassword,
                child: Text(
                  "Change password",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.normal)
                 ),
                 textAlign: TextAlign.center,
                ),  
            )
          )
        ),

        Align(
          alignment: Alignment(Alignment.center.x -0.5, 0.8),
          child: Container(
            width: 110,
            height: 40,            
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: askChangeHostname,
                child: Text(
                  "Change hostname",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)
                 ),
                 textAlign: TextAlign.center,
                ),  
            )
          )
        ),    

        Align(
          alignment: Alignment(Alignment.center.x + 0.5, 0.5),
          child: Container(
            width: 110,
            height: 40,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: sendRestart,
                child: Text(
                  "Restart",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)
                 )
                ),  
            )
          )
        ),    

        Align(
          alignment: Alignment(Alignment.center.x +0.5, 0.65),
          child: Container(
            width: 110,
            height: 40,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: sendKick,
                child: Text(
                  "Kick All",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400 )
                 )
                ),  
            )
          )
        ),  

        Align(
          alignment: Alignment(Alignment.center.x +0.5, 0.8),
          child: Container(
            width: 110,
            height: 40,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color.fromRGBO(49, 188, 	252, 1), Color.fromRGBO(2, 112, 162, 1)]), borderRadius: BorderRadius.all(Radius.circular(2))),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                onPressed: askCommand,
                child: Text(
                  "Send Command",
                  overflow: TextOverflow.visible,
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400)
                 ),
                 textAlign: TextAlign.center,
                ),  
            )
          )
        ),                

      ],
        
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
  
        
      ),
      
    );
  }
}
