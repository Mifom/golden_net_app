import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class ContactsPage extends StatelessWidget {
  final VoidCallback goBack;

  ContactsPage({Key key, this.goBack}) : super(key: key);

  static const String phone = "8 800 500 97 82";
  static const String email = "info@goldenweb.com";
  static const String address = "Москва, Климентовский переулок 2";
  final GlobalKey<OSMFlutterState> osmKey = GlobalKey<OSMFlutterState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Контакты"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back), onPressed: goBack),
        ),
        body: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text("Телефон: $phone"),
                Text("Электронна почта: $email"),
                Text("Адрес: $address"),
                Expanded(
                  child: OSMFlutter(
                    key: osmKey,
                    currentLocation: false,
                    markerIcon: MarkerIcon(
                      icon: Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 80,
                      ),
                    ),
                    initPosition:
                        GeoPoint(latitude: 55.7411658, longitude: 37.6319343),
                  ),
                )
              ],
            )));
  }
}
