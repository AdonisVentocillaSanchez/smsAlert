import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';
import 'package:location/location.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int inicio = 0;

  @override
  Widget build(BuildContext context) {

    String message = "This is a test message!";
    List<String> recipents = ["997966231", "954759224","943480929","922680724"];
    
    var currentLocation = LocationData;
    var location = new Location();
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar sms'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: (){
              Navigator.pushNamed(context, 'contact');
            },
          )
        ],
      ),
      body: Container(
        child: Center(
          child: FlatButton(
            child: Icon(Icons.send),
            onPressed: (){
              //print('prueba');
              setState(() {
               _sendSMS(message, recipents); 
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          location.onLocationChanged().listen((LocationData currentLocation) {
            print(currentLocation.latitude);
            print(currentLocation.longitude);
          });
        },
        child: Icon(Icons.location_searching),
      ),
    );
  }

  void _sendSMS(String message, List<String> recipents, ) async {
    SmsSender sender = new SmsSender();
    for (var i = 0; i < recipents.length; i++) {
      SmsMessage message = new SmsMessage(recipents[i], 'auxiliooooo!');
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
        }
      });
      sender.sendSms(message);
    }
  }
}