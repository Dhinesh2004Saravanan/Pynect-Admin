
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:trackeradmin/mappage.dart';


import 'package:http/http.dart' as http;


class hmain extends StatefulWidget {
  const hmain({super.key});

  @override
  State<hmain> createState() => _hmainState();
}

class _hmainState extends State<hmain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: amain(),);
  }
}



class amain extends StatefulWidget {
  const amain({super.key});

  @override
  State<amain> createState() => _amainState();
}

class _amainState extends State<amain>
{

  Position? position;
  FirebaseMessaging messaging=FirebaseMessaging.instance;
  var cablat;
  var cablon;
  List<LatLng> midpoints=[];

  late AndroidNotificationChannel channel;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  Future<void> GetLocationCoordinates() async
  {
    print("LOCATION CALLED");
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    else if (permission == LocationPermission.deniedForever) {
      return Future.error("LOCATION PERMISSION NOT ENABLED");
    }


    position = await Geolocator.getCurrentPosition();
if(position != null)
{



    print("POSITION IS NOT NULL");
}


    print("POSITION IS $position");
      setState(()
      {
        cablat=position?.latitude;
        cablon=position?.longitude;
      }
      );

      print("Changed position coordinates is $position");
      print("Cab lat and cab lon $cablat ; $cablon");


    await FirebaseFirestore.instance.collection("CAB LOCATION").doc(FirebaseAuth.instance.currentUser?.uid).set({
      "latitude":cablat,
      "longtitude":cablon,
      "userid":FirebaseAuth.instance.currentUser?.uid,
      "token":token

    }).whenComplete(() {
      print("database updation successfull");

    });


    await FirebaseFirestore.instance.collection("CAB USERS").doc(FirebaseAuth.instance.currentUser?.uid).update({
      "location_lat":cablat,
      "location_lon":cablon,


    });



  }



  getNotificationPermission() async
  {
    NotificationSettings settings;
   settings=await messaging.requestPermission(
     announcement: true,
     alert: true,
     badge: true,carPlay: true,
     sound: true
   );
if(settings.authorizationStatus==AuthorizationStatus.authorized)
  {
          print("User has provided the Access for notification");
  }
else if(settings.authorizationStatus==AuthorizationStatus.denied)
  {
    print("USer has denied the permission");
  }
  }

  var token;
  generateNotificationToken() async
  {
      try{
        await messaging.getToken().then((value) {
          if(value!=null)
            {
              setState(() {
                token=value;
              });
            }
        });

        print("TOKEN IS $token");
        await FirebaseFirestore.instance.collection("CAB LOCATION").doc(FirebaseAuth.instance.currentUser?.uid).update({
          "token":token

        });


















      }
      catch(e)
    {
      throw e;
    }
  }




  void listenFCM() async {


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,

              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }



  void loadFCM() async
  {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }














  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLocationCoordinates();

    getNotificationPermission();
    loadFCM();
    listenFCM();
    getUserCoordinates();
    generateNotificationToken();

  }







  getLocationRoute(slat,slon,dlat,dlon) async
  {
    print("function called");
    try
    {


//"https://api.mapbox.com/directions/v5/mapbox/driving/-74.291837%2C40.762911%3B-74.199819%2C40.867373?alternatives=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoiZGhpbmVzaDIwMDQiLCJhIjoiY2xudXpiZnJiMGpqOTJucGF2ejltaDZuNiJ9.7_BuYpxL3qBKoLz2m4pATA"
      //List<LatLng> latlng=[LatLng(11.94236,79.7767635),LatLng(11.958791,79.784181)];

      //  var response =await http.get(Uri.parse("https://api.mapbox.com/directions/v5/mapbox/driving/11.94236%2C79.7767635%3B11.934110%2C79.808040?alternatives=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoiZGhpbmVzaDIwMDQiLCJhIjoiY2xudXpiZnJiMGpqOTJucGF2ejltaDZuNiJ9.7_BuYpxL3qBKoLz2m4pATA"));
      var response=await http.get(Uri.parse("https://trueway-directions2.p.rapidapi.com/FindDrivingPath?origin=$slat%2C$slon&destination=$dlat%2C$dlon"),headers: {
        'X-RapidAPI-Key': 'f57d0797demsh1cd143822f6247fp185348jsnd47f87ec4638',
        'X-RapidAPI-Host': 'trueway-directions2.p.rapidapi.com'
      },

      );

      //print("response is ${response.body}");



      var answerjson=jsonDecode(response.body);
      print("JSON FORMAT ${answerjson}");

      print("answer is   ${answerjson["route"]["geometry"]["coordinates"]}");

      var final_ans=answerjson["route"]["geometry"]["coordinates"];

      print(final_ans[0]);


      var lat=final_ans[0][0];
      var lon=final_ans[0][1];


      for (int i=0;i<final_ans.length-1;i++)
      {
        var lat=final_ans[i][0];
        var lon=final_ans[i][1];
        setState(() {
          midpoints.add(LatLng(lat, lon));
        });
      }
      print(midpoints[0]);
      print("MIDPOINTS IS $midpoints");










      // var response=await http.post(Uri.parse("https://api.openrouteservice.org/v2/directions/driving-car"),
      //     headers: {
      //       "Content-Type":"application/json",
      //       "Authorization":"5b3ce3597851110001cf6248a4a4c7faadf6468aaafe21acfdd57c87"
      //     }
      //     ,body: '{"coordinates":[[8.681495,49.41461],[8.686507,49.41943]]}'
      //
      // );
      //
      // print("Response is $response");
      // print("response body is ${response.body}");
      //
      // final mapanswer=jsonDecode(response.body);
      //
      // print("features is ${mapanswer["geometry"]}");




    }
    catch(e)
    {
      print(e);
    }


  }







var finalan;
 var lat;
 var lon;


  getUserCoordinates() async{
    var answer=await FirebaseFirestore.instance.collection("USERS COORDINATES").get();
    finalan= answer.docs.map((e) =>e.data()).toList();
    print("answer final is $finalan");

setState(() {
  lat=finalan[0]["latitude"];
  lon=finalan[0]["longtitude"];
});
  




  }





    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("MAPPAGE"),),








      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        getLocationRoute(lat, lon, cablat, cablon);
      },child: Icon(FontAwesomeIcons.route),),



      body: FlutterMap
        (
          options:MapOptions(
          zoom:15,
          maxZoom: 19
        ),
        children: [
          TileLayer
            (urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
          CurrentLocationLayer(
            followOnLocationUpdate: FollowOnLocationUpdate.always,
            turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
            style: LocationMarkerStyle(
              marker: DefaultLocationMarker
                (
                  child: Icon(Icons.navigation,color: Colors.white,),
                ),markerSize: Size(15,15)
            ),
          ),


          (lat==null && lon==null)?(MarkerLayer(
            markers: [
              Marker(point: LatLng(0,0), builder: (context)=>Container(
                child: Icon(Icons.ac_unit),
              ))
            ],
          )):MarkerLayer(
            markers: [
              Marker(point: LatLng(lat, lon), builder: (context)=>Container(child:Icon(Icons.ac_unit)))
            ],
          ),
          PolylineLayer(
            polylines:
            [
              // (currentposition!.latitude==null && currentposition!.longitude==null)?
              //                                      (Polyline(points: [LatLng(0,0)])):(Polyline(points: [LatLng(currentposition!.latitude,currentposition!.longitude )])),
              Polyline(points: midpoints,strokeWidth: 2,color: Colors.black),

            ],
          )
        ]
      ),
    );
  }


}

