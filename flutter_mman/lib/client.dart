import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
  
import 'main.dart';  


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'client',
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
      home: const MyHomePage_Client(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage_Client extends StatefulWidget {
  const MyHomePage_Client({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage_Client> createState() => _MyHomePageState_Client();
}

class _MyHomePageState_Client extends State<MyHomePage_Client> {
  int _counter = 0;
  int pageIndex = 0;
  
  String gamemode = "?";
  String player_count = "?";
  String map = "?";
  String uptime = "?";


  String hostname = "Loading...";



  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void sendAction(action, steamid){
    http.post(Uri.parse('https://32a6-185-252-220-156.ngrok-free.app/gmod/command.php'),
      headers:{
      },
      body: {'command' : '$action:$steamid'}
    );    
  }

  void askAction(steamid)async{
     showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Select Action',
            style: GoogleFonts.inter(textStyle: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold))
            ),
          backgroundColor: Color.fromRGBO(48,	54,	73, 100),
          content: Container(
            width: 400,
            height: 400,
            child: ListView(
            children: [
              for (var command in Server.commands ?? {})
                ListTile(
                  onTap: () async =>{
                    sendAction(command["key"], steamid),
                    Navigator.pop(context)
                  },
                  title: Text(
                    command["value"],
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
                      ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,                    
                  )
                ) 
            ],
          ),
          ),
          
          actions: <Widget>[
            ElevatedButton(
              child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black)),
              onPressed: () => {
                setState((){}),
                Navigator.pop(context)
              },
            )
          ]
        );
      }
    );
  }   

  void refresh()async{
    setState((){});
    Future.delayed(const Duration(seconds: 5), (){
      refresh();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
    refresh();
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
            // decoration: const BoxDecoration(
            //   border: Border(bottom: BorderSide(
            //     color: Colors.white,
            //     width: 2.0,
            //   ))
            // ),
            child: TextButton(
              onPressed: () {Navigator.pop(context);},
              child:  Text(
                "server",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white38, fontSize: 30)
                )
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
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
              ))
            ),            
            child: Text(
              "client",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white, fontSize: 30)
               )
            )
          )
        ),        
        Align(
          alignment: Alignment(Alignment.center.x,-0.5),
          child: Container(
            width: 300,
            padding: const EdgeInsets.only(bottom: 15),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ))
            ),
            child: const Icon(
              Icons.supervised_user_circle_rounded,
              color: Colors.white,
              size: 32,
            )
          )
        ),   

        Align(
          alignment: Alignment(Alignment.center.x, 0.4),
          child: Container(
            width: 360,
            height: 500,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                for (var player in Server.players ?? {})
                  ListTile(
                    minVerticalPadding: 0,
                    onTap: () async =>{
                      askAction(player["steamid"])
                  },
                  title: Text(
                    '${player["name"]} | ${player["steamid"]}',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,                    
                  )
                ) 
              ],
            ),
          )
        ),
        // buttons                   
      ],
      ),
      
    );
  }
}
