import 'package:flutter/material.dart';
import 'package:sms_maintained/sms.dart';
import 'package:location/location.dart';
import 'package:sms/ui/status.dart';

class MovimientosPage extends StatefulWidget {
  final int type;

  MovimientosPage({Key key, this.type}) : super(key: key);
  @override
  MovimientosPageState createState() => MovimientosPageState();
}

class MovimientosPageState extends State<MovimientosPage> {
  final _formKey = GlobalKey<FormState>();

  //valores de los check
  bool mov1 = false;
  bool mov2 = false;
  bool mov3 = false;
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
    String message = "https://www.readeranswer.com/index.php?";
    List<String> recipents = ["955312775"];
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
                const SizedBox(height: 60.0),
                Center(
                  child: Text(
                    'Facilidad de Movimiento',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Segoe UI',
                      color: Colors.grey,
                      fontSize: 30.0,
                    ),
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
                              labelText: 'Sin Movimiento', enabled: false),
                        ),
                      ),
                      Checkbox(
                        value: mov1,
                        onChanged: (bool value) {
                          setState(() {
                            mov1 = value;
                            mov2 = false;
                            mov3 = false;
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
                              labelText: 'Movimiento Parcial', enabled: false),
                        ),
                      ),
                      Checkbox(
                        value: mov2,
                        onChanged: (bool value) {
                          setState(() {
                            mov2 = value;
                            mov1 = false;
                            mov3 = false;
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
                              labelText: 'Atrapado', enabled: false),
                        ),
                      ),
                      Checkbox(
                        value: mov3,
                        onChanged: (bool value) {
                          setState(() {
                            mov3 = value;
                            mov1 = false;
                            mov2 = false;
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
                      if (mov1 == true) {
                        print("Fracturas Graves");
                        _sendSMS(lat.toString(), lng.toString(), "954759224",
                            widget.type, 1, recipents);
                      }
                      if (mov2 == true) {
                        print("Fracturas Leves");
                        _sendSMS(lat.toString(), lng.toString(), "954759224",
                            widget.type, 2, recipents);
                      }
                      if (mov3 == true) {
                        print("Golpes Leves");
                        _sendSMS(lat.toString(), lng.toString(), "954759224",
                            widget.type, 3, recipents);
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
    int type2,
    List<String> recipents,
  ) {
    SmsSender sender = new SmsSender();
    for (var i = 0; i < recipents.length; i++) {
      SmsMessage message = new SmsMessage(
          recipents[i],
          'https://www.readeranswer.com/index.php?lat=' +
              lat +
              '&lng=' +
              lng +
              '&f=' +
              type.toString() +
              '&m=' +
              type2.toString() +
              '&s=0' +
              '&t=' +
              number);
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StatusPage()));
        }
      });
      sender.sendSms(message);
    }
  }
}
