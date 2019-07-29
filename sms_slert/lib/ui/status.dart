import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sms_maintained/sms.dart';
import 'package:sms/ui/fracturas.dart';

class StatusPage extends StatefulWidget {
  @override
  StatusPageState createState() => StatusPageState();
}

class StatusPageState extends State<StatusPage> {
  final _formKey = GlobalKey<FormState>();

  //valores de los check
  bool fractura1 = false;
  bool fractura2 = false;
  bool fractura3 = false;
  var location = new Location();
  double lat = 0;
  double lng = 0;

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      lat = currentLocation.latitude;
      lng = currentLocation.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> recipents = ["950999807"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status de Emergencia'),
        backgroundColor: Colors.blue[700],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: 'He sido rescatado', enabled: false),
                        ),
                      ),
                      Checkbox(
                        value: fractura1,
                        onChanged: (bool value) {
                          setState(() {
                            fractura1 = value;
                            fractura2 = false;
                            fractura3 = false;
                          });
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              labelText: 'Estoy fuera de peligro',
                              enabled: false),
                        ),
                      ),
                      Checkbox(
                        value: fractura2,
                        onChanged: (bool value) {
                          setState(() {
                            fractura2 = value;
                            fractura1 = false;
                            fractura3 = false;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                ButtonTheme(
                  minWidth: 350.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (fractura1 == true) {
                        print("Fracturas Graves");
                        _sendSMS(lat.toString(), lng.toString(), "950999807", 1,
                            recipents);
                      }
                      if (fractura2 == true) {
                        print("Fracturas Leves");
                        _sendSMS(lat.toString(), lng.toString(), "950999807", 2,
                            recipents);
                      }
                    },
                    textColor: Colors.white,
                    child: Text(
                      "ENVIAR",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendSMS(
    String lat,
    String lng,
    String number,
    int type,
    List<String> recipents,
  ) {
    SmsSender sender = new SmsSender();
    for (var i = 0; i < recipents.length; i++) {
      SmsMessage message = new SmsMessage(
          recipents[i],
          'https://smsalert.mybluemix.net?lat=' +
              lat +
              '&lng=' +
              lng +
              '&f=0&m=0&s=' +
              type.toString() +
              '&t=' +
              number);
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => FracturasPage()));
        }
      });
      sender.sendSms(message);
    }
  }
}
