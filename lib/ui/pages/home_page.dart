import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  HomePage({Key key}):super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Image.asset("assets/logo_flat.png", height: 40,))),
      body: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(16),
          child: Image.asset("assets/banner.jpeg"),
        ),
      ),
    );
  }
}
